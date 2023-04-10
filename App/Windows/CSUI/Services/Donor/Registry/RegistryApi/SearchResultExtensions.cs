using Statline.Common.Utilities;
using Statline.Registry.Api.Client;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;

namespace Stattrac.Services.Donor.Registry.RegistryApi
{
    internal static class SearchResultExtensions
    {
        public static IEnumerable<Model.DonorSearchResult> ToDonorSearchResults(
            this IEnumerable<SearchResult> searchResults)
        {
            Check.NotNull(searchResults, nameof(searchResults));
            return searchResults.Select(ToDonorSearchResult);
        }

        public static Model.DonorSearchResult ToDonorSearchResult(this SearchResult searchResult)
        {
            Check.NotNull(searchResult, nameof(searchResult));

            return new Model.DonorSearchResult(
                CommonConverter.ParseId(searchResult.SourceID),
                new Model.DonorRegistryInfo(
                    CommonConverter.RegistryNameToRegistryType(searchResult.SourceName),
                    searchResult.SourceState,
                    searchResult.SourceOwnerState),
                new Model.DonorPerson(
                    new Model.DonorName(
                        searchResult.FirstName,
                        searchResult.MiddleName,
                        searchResult.LastName),
                    new Model.DonorAddress(
                        address1: searchResult.Address,
                        address2: null,
                        searchResult.City,
                        searchResult.State,
                        searchResult.Zip),
                    // TODO: Search result should contain strongly typed date
                    // TODO: Theoretically DOB can be null, need to handle this.
                    // but with the previous TODO this will be already fixed. 
                    DateTime.Parse(searchResult.DOB, CultureInfo.InvariantCulture),
                    searchResult.SID,
                    searchResult.SSN),
                searchResult.VerificationForm,
                searchResult.DonorDate,
                searchResult.DonorDateType,
                searchResult.OnRegistry,
                searchResult.DonorConfirmed);
        }

       
    }
}
