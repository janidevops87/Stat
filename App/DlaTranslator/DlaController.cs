using Registry.Common.DTO;
using Registry.Web.UI.Controllers;
using Registry.Web.UI.DAL;
using Registry.Web.UI.ViewModels;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace Statline.Stattrac.DlaTranslator
{
    public class DlaController
    {
        private static readonly CultureInfo UsCultureInfo = CultureInfo.GetCultureInfo("EN-us");

        public async Task<RegistryDlaResponse> GetDlaSearchResultsAsync(RegistryDlaRequest request)
        {
            //Initialize Objects
            WebApiDataProvider provider = new WebApiDataProvider();
            SearchController controller = new SearchController(provider);
            SearchRequest searchRequest = new SearchRequest();
            DateTime searchStartDateTime = DateTime.Now;

            //Populate Request Parameters
            searchRequest.FirstName = request.FirstName;
            searchRequest.MiddleName = request.MiddleName;
            searchRequest.LastName = request.LastName;
            searchRequest.DOB = request.DOB;

            //Call Web Service To Get Results
            JsonResult jsonResult = await controller.SearchRegistry(searchRequest).ConfigureAwait(false);

            //Use Result Items To Build RegistryDlaResponse Object
            RegistryDlaResponse registryDlaResponse = new RegistryDlaResponse();
            List<string> errors = ((AjaxResponseViewModel<List<SearchResultGrouped>>)jsonResult.Data).Errors;
            registryDlaResponse.ErrorCount = errors.Count;
            registryDlaResponse.ErrorDescription = String.Join(", ", errors.ToArray());
            if (((AjaxResponseViewModel<List<SearchResultGrouped>>)jsonResult.Data).Item.Count > 0)
            {
                SearchResultGrouped searchResults = ((AjaxResponseViewModel<List<SearchResultGrouped>>)jsonResult.Data).Item[0];
                foreach (SearchResult searchResultItem in searchResults.Items)
                {
                    RegistryDlaResponseItem newItem = new RegistryDlaResponseItem();
                    newItem.SourceName = searchResultItem.SourceName;
                    newItem.FirstName = searchResultItem.FirstName;
                    newItem.MiddleName = searchResultItem.MiddleName;
                    newItem.LastName = searchResultItem.LastName;
                    newItem.DOB = searchResultItem.DOB;
                    newItem.Address = searchResultItem.Address;
                    newItem.City = searchResultItem.City;
                    newItem.State = searchResultItem.State;
                    newItem.Zip = searchResultItem.Zip;
                    newItem.DonorDate = FormatDonorDate(searchResultItem);
                    newItem.SID = searchResultItem.SID;
                    newItem.SSN = searchResultItem.SSN;
                    newItem.DonorStatus = searchResultItem.DonorStatus;
                    registryDlaResponse.Items.Add(newItem);
                };
            }
            registryDlaResponse.ItemCount = registryDlaResponse.Items.Count;
            registryDlaResponse.RequestDateTime = searchStartDateTime;
            registryDlaResponse.ResponseDateTime = DateTime.Now;

            return registryDlaResponse; 
        }

        private static string FormatDonorDate(SearchResult result)
        {
            if (result.DonorDate is null)
            {
                return null;
            }

            var donorDateString = result.DonorDate.Value.ToString("d", UsCultureInfo);

            return result.DonorDateType is null ?
                donorDateString :
                $"{result.DonorDateType}: {donorDateString}";
        }
    }
}
