using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Security.Cryptography.X509Certificates;
using System.Web.Script.Serialization;
using Jose;
using Newtonsoft.Json;
using Registry.Common.DTO;
using Registry.Common.Extensions;
using Registry.Common.Util;

namespace Registry.API.Dla
{
    public class DlaApiClient
    {
        #region Public Methods
        public IEnumerable<SearchResult> Search(SearchRequest searchRequest)
        {
            var searchResultList = new List<SearchResult>();

            try
            {
                InternalSearch(searchRequest, searchResultList);
                InternalSearch(searchRequest, searchResultList, "F");
            }
            catch (Exception e)
            {
                //external service should not impact the regular search
                var logger = RegistryLogger.CreateInstance("Registry.API");
                logger.Write(e);
            }

            return Filter(searchResultList, searchRequest);
        }

        public SearchResult Get(int id)
        {
            using (var client = GetDLAClient())
            {
                return GetById(client, id.ToString());
            }
        }
        #endregion

        #region Private Methods
        private DlaToken GetToken()
        {
            string returnValue;
            var certificate = new X509Certificate2(DlaSettings.DlaCertificateFile, DlaSettings.DlaCertificatePassword
                , X509KeyStorageFlags.MachineKeySet);
            //Microsoft Enhanced RSA and AES Cryptographic Provider
            var key = certificate.PrivateKey;
            var token = JWT.Encode(GetPayload(), key, JwsAlgorithm.RS256);

            using (var client = new WebClient())
            {
                client.Headers.Add("Content-Type", "application/x-www-form-urlencoded");
                var response = client.UploadString(DlaSettings.DlaToken, "assertion=" + token + "&grant_type=urn:ietf:params:oauth:grant-type:jwt-bearer");
                returnValue = response;
            }

            var srl = new JavaScriptSerializer();
            return srl.Deserialize<DlaToken>(returnValue);
        }

        private void InternalSearch(SearchRequest searchRequest, List<SearchResult> searchResultList, string gender = "M")
        {
            var dob = (searchRequest.DOB.HasValue && searchRequest.DOB.Value != new DateTime(1900, 1, 1))
                ? searchRequest.DOB.Value.ToString("MM/dd/yyyy")
                : null;
            var state = GetState(searchRequest);
            //build Url
            var url = new Uri(DlaSettings.DlaSearchUrl)
                    .AddQuery("firstname", searchRequest.FirstName)
                    .AddQuery("lastname", searchRequest.LastName)
                    .AddQuery("gender", gender)
                    .AddQuery("state", state)
                    .AddQuery("dob", dob);

            using (var client = GetDLAClient())
            {
                var retString = client.DownloadString(url);
                var dlaSearchResult = JsonConvert.DeserializeObject<DlaSearchResult>(retString);

                searchResultList.AddRange(dlaSearchResult.registrants
                    .Select(r => GetById(client, r.Id)));
            }
        }

        private WebClient GetDLAClient()
        {
            var dlaToken = GetToken();
            var client = new WebClient
            {
                Headers = {[HttpRequestHeader.Authorization] = $"Bearer {dlaToken.Access_Token}" }
            };

            return client;
        }

        private static SearchResult GetById(WebClient dlaClient, string id)
        {
            var srl = new JavaScriptSerializer();
            return TransformResponse(srl.Deserialize<Registrants>(dlaClient.DownloadString(DlaSettings.DlaGetUrl + id)));
        }

        private static string GetState(SearchRequest searchRequest)
        {
            if ((string.IsNullOrEmpty(searchRequest.State) || searchRequest.State.Equals("*")))
                return null;

            return searchRequest.State;
        }

        private static SearchResult TransformResponse(Registrants registrants)
        {
            return new SearchResult
            {
                RegistrySearchResultSID = registrants.Id,
                RegistrySearchResultFirstName = registrants.FirstName,
                RegistrySearchResultLastName = registrants.LastName,
                RegistrySearchResultMiddleName = registrants.MiddleName,
                RegistrySearchResultDOB = registrants.Dob,
                RegistrySearchResultAddress = registrants.Address1 + " " + registrants.Address2,
                RegistrySearchResultCity = registrants.City,
                RegistrySearchResultState = registrants.State,
                RegistrySearchResultZip = registrants.Zip,
                RegistrySearchResultDonorDate = registrants.Last_Modified_Date,
                RegistrySearchResultDonorStatus = "Yes on Registry",
                RegistrySearchResultSourceName = "DLA",
                RegistrySearchResultSSN = registrants.Last4SSN
            };

        }

        private static IEnumerable<SearchResult> Filter(IEnumerable<SearchResult> searchResultList, SearchRequest searchRequest)
        {
            var ret = searchResultList.AsEnumerable();

            ret = StartsWith(ret, r => r.RegistrySearchResultZip, searchRequest.Zip);
            ret = StartsWith(ret, r => r.RegistrySearchResultCity, searchRequest.City);
            ret = StartsWith(ret, r => r.RegistrySearchResultFirstName, searchRequest.FirstName);
            ret = StartsWith(ret, r => r.RegistrySearchResultMiddleName, searchRequest.MiddleName);
            ret = StartsWith(ret, r => r.RegistrySearchResultLastName, searchRequest.LastName);

            return ret;
        }

        private static IEnumerable<SearchResult> StartsWith(IEnumerable<SearchResult> sequence, Func<SearchResult, string> selector, string filter)
        {
            return string.IsNullOrEmpty(filter)
                ? sequence
                : sequence.Where(x => (selector(x) ?? "").StartsWith(filter, StringComparison.InvariantCultureIgnoreCase));
        }

        private Dictionary<string, object> GetPayload()
        {
            var time1970 = new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc);
            var timeSince1970 = Math.Round((DateTime.UtcNow - time1970).TotalSeconds);

            return new Dictionary<string, object>
            {
                { "iss", DlaSettings.DlaAppId },
                { "aud", DlaSettings.DlaUrl },
                { "iat", timeSince1970 }
            };
        }
        #endregion
    }
}
