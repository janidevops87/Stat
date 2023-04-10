using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Newtonsoft.Json;
using Registry.Common.DTO;
using Registry.API.Dla;

namespace Registry.API.DAL
{
    public class EFSearchDataProvider : EFDataProviderBase, ISearchDataProvider
    {
        private const string _searchSprocName = "GetDataListRegistrySearchResults";

        public async Task<IEnumerable<SearchResult>> SearchRegistry(SearchRequest registrySearchParams)
        {
            using (var context = RegistryDb)
            {
                var result = ExecuteStoredProcedure<SearchResult, SearchRequest>(_searchSprocName, AdjustWildcards(registrySearchParams), context).Result;

                if (registrySearchParams.DisplayDLADonors.HasValue && registrySearchParams.DisplayDLADonors.Value)
                {
                    var dlaApiClient = new DlaApiClient();
                    var dlaResult = dlaApiClient.Search(registrySearchParams);
                    result = result.Concat(dlaResult);
                }

                return await Task.Run(() => result);
            }
        }

        public Task<SearchResult> SearchDlaRegistry(int id)
        {
            return Task.Run(() => new DlaApiClient().Get(id));
        }
        /// <summary>
        /// Add * to proper fields
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        private static SearchRequest AdjustWildcards(SearchRequest request)
        {
            var deserializeSettings = new JsonSerializerSettings { ObjectCreationHandling = ObjectCreationHandling.Replace };
            //clone object
            var ret = JsonConvert.DeserializeObject<SearchRequest>(JsonConvert.SerializeObject(request), deserializeSettings);

            ret.FirstName = AsteriskIt(ret.FirstName);
            ret.MiddleName = AsteriskIt(ret.MiddleName);
            ret.LastName = AsteriskIt(ret.LastName);
            ret.Zip = AsteriskIt(ret.Zip);
            ret.City = AsteriskIt(ret.City);

            return ret;
        }

        private static string AsteriskIt(string field)
        {
            return string.IsNullOrEmpty(field) ? "*" : $"{field.Replace("*", "")}*";
        }
    }
}
