using Registry.API.DAL;
using Registry.Common.DTO;
using Registry.Common.Enums;
using Registry.Common.Idology;
using Registry.Common.Util;
using System.Collections.Generic;
using System.IO;
using System.Net.Http;
using System.Text;
using System.Web.Configuration;
using System.Xml.Serialization;

namespace Registry.API.Idology
{
    public class IdologyApiClient
    {
        #region Private Fields
        private string RequestUrl { get { return WebConfigurationManager.AppSettings["IDology.WebServiceRequestURL"]; } }
        private string IDology_WebServiceQuestionsURL { get { return WebConfigurationManager.AppSettings["IDology.WebServiceQuestionsURL"]; } }
        #endregion

        #region Public Methods
        /// <summary>
        /// Verify registry from idology
        /// </summary>
        /// <param name="_dataProvider">data provider</param>
        /// <param name="registry">Contains teh registry information</param>
        /// <returns></returns>
        public PostRegistryResponse VerifyRegistrant(IEnrollmentDataProvider _dataProvider, Common.DTO.Registry registry)
        {
            var result = new PostRegistryResponse { RegistryApiResult = RegistryApiError.NoError, RegistryID = registry.RegistryID, };
            var registryOwner = _dataProvider.GetRegistryOwner(registry.RegistryOwnerID.Value);

            if ((registryOwner.IDologyActive == false)
                || ((registry.IsInternalEnrollment == true) && (registryOwner.IdologyActiveInPortal == false))
            )
            {
                return result;
            }

            string request = string.Empty;
            string apiResponse = string.Empty;

            using (var client = new HttpClient())
            {
                HttpContent content = GetRequestHttpContent(registryOwner, registry, out request);
                apiResponse = client.PostAsync(RequestUrl, content).Result.Content.ReadAsStringAsync().Result;
                _dataProvider.InsertIDologyLog(registry.RegistryID.Value, request, apiResponse);
                XmlSerializer xmlSerializer = new XmlSerializer(typeof(Response));
                result.Response = (Response)xmlSerializer.Deserialize(new StringReader(apiResponse));
                result.RegistryApiResult = (result.Response == null) ? RegistryApiError.VerificationFailed : result.Response.ResponseType;
            }

            return result;
        }

        public PostRegistryResponse VerifyAnswers(IEnrollmentDataProvider _dataProvider, IDologyAnswersRequest answersRequest, int registryOwnerID)
        {
            var result = new PostRegistryResponse { RegistryApiResult = RegistryApiError.NoError, RegistryID = answersRequest.RegistryID, };
            var registryOwner = _dataProvider.GetRegistryOwner(registryOwnerID);
            string request = string.Empty;
            string apiResponse = string.Empty;

            using (var client = new HttpClient())
            {
                HttpContent content = null;

                switch (answersRequest.Response.ResponseType)
                {
                    case RegistryApiError.DifferentiatorQuestion:
                        content = GetRequestHttpContent_DifferentiatorQuestion(registryOwner, answersRequest.Language, answersRequest.Response, out request);
                        break;
                    case RegistryApiError.SecurityQuestion:
                        content = GetRequestHttpContent_SecurityQuestion(registryOwner, answersRequest.Language, answersRequest.Response, out request);
                        break;
                    default:
                        result.RegistryApiResult = RegistryApiError.VerificationFailed;
                        result.Response = null;

                        return result;
                }
                apiResponse = client.PostAsync(IDology_WebServiceQuestionsURL, content).Result.Content.ReadAsStringAsync().Result;
                _dataProvider.InsertIDologyLog(answersRequest.RegistryID, request, apiResponse);
                XmlSerializer xmlSerializer = new XmlSerializer(typeof(Response));
                result.Response = (Response)xmlSerializer.Deserialize(new StringReader(apiResponse));
                result.RegistryApiResult = (result.Response == null) ? RegistryApiError.VerificationFailed : result.Response.ResponseType;
            }

            return result;
        }
        #endregion

        #region Private Methods
        private HttpContent GetRequestHttpContent(DAL.Databases.Registry.Entities.RegistryOwner registryOwner, Common.DTO.Registry registry, out string request)
        {
            // Idology requires that we send the information in post
            List<KeyValuePair<string, string>> postData = new List<KeyValuePair<string, string>>();
            postData.Add(new KeyValuePair<string, string>("firstName", registry.FirstName));
            postData.Add(new KeyValuePair<string, string>("lastName", registry.LastName));
            postData.Add(new KeyValuePair<string, string>("address", registry.Address1 + " " + registry.Address2));
            postData.Add(new KeyValuePair<string, string>("city", registry.City));
            postData.Add(new KeyValuePair<string, string>("state", registry.State));
            postData.Add(new KeyValuePair<string, string>("zip", registry.Zip));
            if (registry.DOB != null)
            {
                postData.Add(new KeyValuePair<string, string>("dobMonth", registry.DOB.Value.Month.ToString()));
                postData.Add(new KeyValuePair<string, string>("dobDay", registry.DOB.Value.Day.ToString()));
                postData.Add(new KeyValuePair<string, string>("dobYear", registry.DOB.Value.Year.ToString()));
            }
            postData.Add(new KeyValuePair<string, string>("ssnLast4", registry.SSN));
            request = GetRequest(registryOwner, registry.Language, postData);
            return new FormUrlEncodedContent(postData);
        }

        public HttpContent GetRequestHttpContent_DifferentiatorQuestion(DAL.Databases.Registry.Entities.RegistryOwner registryOwner, LanguagesEnum lng, Response idologyResponse, out string request)
        {
            // Idology requires that we send the information in post
            List<KeyValuePair<string, string>> postData = new List<KeyValuePair<string, string>>();
            postData.Add(new KeyValuePair<string, string>("idNumber", idologyResponse.IdNumber));
            postData.Add(new KeyValuePair<string, string>("question1Type", idologyResponse.DifferentiatorQuestion.Type));
            postData.Add(new KeyValuePair<string, string>("question1Answer", idologyResponse.DifferentiatorQuestion.SelectedAnswer));
            request = GetRequest(registryOwner, lng, postData);
            return new FormUrlEncodedContent(postData);
        }

        public HttpContent GetRequestHttpContent_SecurityQuestion(DAL.Databases.Registry.Entities.RegistryOwner registryOwner, LanguagesEnum lng, Response idologyResponse, out string request)
        {
            // Idology requires that we send the information in post
            List<KeyValuePair<string, string>> postData = new List<KeyValuePair<string, string>>();
            postData.Add(new KeyValuePair<string, string>("idNumber", idologyResponse.IdNumber));
            for (int index = 0; index < idologyResponse.Questions.Question.Count; index++)
            {
                postData.Add(new KeyValuePair<string, string>("question" + (index + 1) + "Type", idologyResponse.Questions.Question[index].Type));
                postData.Add(new KeyValuePair<string, string>("question" + (index + 1) + "Answer", idologyResponse.Questions.Question[index].SelectedAnswer));
            }
            request = GetRequest(registryOwner, lng, postData);
            return new FormUrlEncodedContent(postData);
        }

        private string GetRequest(DAL.Databases.Registry.Entities.RegistryOwner registryOwner, LanguagesEnum lng, List<KeyValuePair<string, string>> postData)
        {
            // Get the decrypted username and pasword
            string userName = (lng == LanguagesEnum.Es) ? EncryptionManager.Decrypt(registryOwner.IDologySpLogin) : EncryptionManager.Decrypt(registryOwner.IDologyLogin);
            string password = (lng == LanguagesEnum.Es) ? EncryptionManager.Decrypt(registryOwner.IDologySpPassword) : EncryptionManager.Decrypt(registryOwner.IDologyPassword);

            //idologyResponse.IdNumber, idologyResponse.Questions.Question[0].Type, idologyResponse.Questions.Question[0].SelectedAnswer);
            postData.Add(new KeyValuePair<string, string>("username", userName));
            postData.Add(new KeyValuePair<string, string>("password", password));

            StringBuilder sbRrequest = new StringBuilder();
            foreach (KeyValuePair<string, string> item in postData)
            {
                sbRrequest.AppendFormat("&{0}={1}", item.Key, item.Value);
            }
            return sbRrequest.ToString();
        }
        #endregion
    }
}
