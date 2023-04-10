using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web.Mvc;
using AutoMapper;
using Registry.Common.DTO;
using Registry.Web.UI.DAL;
using Registry.Web.UI.ViewModels;

namespace Registry.Web.UI.Controllers
{
    [Authorize]
    public class SearchController : BaseController
    {
        private IDictionary<string, int> GroupsOrder { get; } = new Dictionary<string, int> { { "WEB", 0 }, { "DLA", 1 } };

        public SearchController(IApiDataProvider provider) :
            base(provider)
        {
        }

        [Route("searchregistry")]
        public async Task<JsonResult> SearchRegistry(SearchRequest request)
        {
            var result = new AjaxResponseViewModel<List<SearchResultGrouped>>();

            Mapper.CreateMap<SearchRequest, SearchRequest>()
                .ForAllMembers(opt => opt.Condition(srs => !srs.IsSourceValueNull));
            var currentRequest = SearchRequest.GetDefaultSearchRequest();
            Mapper.Map(request, currentRequest);

            var isDmvSpecialCase = false; // Enum.GetNames(typeof(DMVSpecialCasesEnum)).Contains(CurrentUser.RegistryOwnerRouteName.ToUpper());

            if (!isDmvSpecialCase)
            {
                //currentRequest.StateSelection = "DLA";// CurrentClient.DMVStates.Where(x => !string.IsNullOrEmpty(x)).Aggregate("", (s, s1) => $"{s},{s1.ToUpper()}");
            }

            //currentRequest.RegistryOwnerID = 2; //NEOB... CurrentUser.RegistryOwnerId;
            currentRequest.StateSelection = "DLA";
            currentRequest.DisplayNoDonors = true;
            currentRequest.DisplayWebDonors = false;
            currentRequest.DisplayDMVDonors = false;
            currentRequest.DisplayDLADonors = true;

            //WriteLog("SearchRequest", request, "Search Parameters");

            var registryModels = await ApiDataProvider.SearchRegistry(currentRequest);
            result.Success = registryModels.Success;

            if (result.Success)
            {
                result.Item = GroupResults(registryModels.Item);
                //WriteLog("SearchResult", result.Item, "Search Results");
            }
            else
            {
                //Add an empty item list
                result.Item = new List<SearchResultGrouped>();
                result.Errors.AddRange(registryModels.Errors);
                //WriteLog("SearchResult", result.Errors, "Search Errors");
            }

            return Json(result);
        }

        private List<SearchResultGrouped> GroupResults(IEnumerable<SearchResult> searchResults)
        {
            var result = new List<SearchResultGrouped>();

            if (searchResults == null)
                return result;

            foreach (var item in searchResults.OrderBy(i => i.LastName).ThenBy(i => i.FirstName))
            {
                var groupState = GetGroupState(item);
                //todo: add group ordering
                var group = result.FirstOrDefault(i => i.State == groupState);
                if (group == null)
                {
                    group = new SearchResultGrouped { State = groupState };
                    result.Add(group);
                }

                group.Order = GetGroupOrder(group.State);
                group.Total++;
                group.Items.Add(item);
            }

            return result.OrderBy(x => x.Order).ThenBy(x => x.State).ToList();
        }

        private int GetGroupOrder(string state)
        {
            if (GroupsOrder.ContainsKey(state))
                return GroupsOrder[state];

            return GroupsOrder.Values.Max() + 1;
        }

        private static string GetGroupState(SearchResult item)
        {
            var groupState =
                new[] { "WEB", "DLA" }.FirstOrDefault( //todo: create collection of defined groups
                    x => x.Equals(item.SourceName, StringComparison.InvariantCultureIgnoreCase));


            if (string.IsNullOrEmpty(groupState))
                return "DMV " + item.SourceState;


            return groupState;
        }
    }
}