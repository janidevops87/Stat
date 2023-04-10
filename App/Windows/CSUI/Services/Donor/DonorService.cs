using Statline.Common.Utilities;
using Stattrac.Services.Donor.Registry;
using Stattrac.Services.Donor.Registry.Model;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Threading.Tasks;

namespace Stattrac.Services.Donor
{
    /// <dev>
    /// The goal of this class is to provide business features. 
    /// It should not contain any cross-cutting concerns such as 
    /// exceptions logging.
    /// </dev>
    public class DonorService
    {
        private readonly IDonorRegistry donorRegistry;
        private readonly IDonorServiceConfigurationProvider configurationProvider;

        public DonorService(
            IDonorRegistry donorRegistry,
            IDonorServiceConfigurationProvider configurationProvider)
        {
            Check.NotNull(donorRegistry, nameof(donorRegistry));
            Check.NotNull(configurationProvider, nameof(configurationProvider));
            this.donorRegistry = donorRegistry;
            this.configurationProvider = configurationProvider;
        }

        #region Search

        public async Task<DonorSearchResult[]> SearchRegistryAsync(DonorSearchRequest searchRequest)
        {
            Check.NotNull(searchRequest, nameof(searchRequest));

            var config = await configurationProvider.GetConfigurationAsync().ConfigureAwait(false);

            var searchResults = await donorRegistry.SearchDonorsAsync(searchRequest, config.Search).ConfigureAwait(false); ;

            return FilterSearchResults(searchResults, searchRequest).ToArray();
        }

        private IEnumerable<DonorSearchResult> FilterSearchResults(
            IEnumerable<DonorSearchResult> searchResults,
            DonorSearchRequest searchRequest)
        {
            // Registry does somewhat fuzzy search, but we need
            // exact first and last name match.
            searchResults =
                from sr in searchResults
                where
                    // We have to use Compare instead of Equals
                    // to be able to use options provided via CompareOptions.
                    string.Compare(sr.Person.Name.FirstName, searchRequest.DonorFirstName, 
                        CultureInfo.InvariantCulture, 
                        CompareOptions.IgnoreSymbols | 
                        CompareOptions.IgnoreNonSpace | 
                        CompareOptions.IgnoreCase) == 0 &&
                    string.Compare(sr.Person.Name.LastName, searchRequest.DonorLastName,
                        CultureInfo.InvariantCulture,
                        CompareOptions.IgnoreSymbols |
                        CompareOptions.IgnoreNonSpace |
                        CompareOptions.IgnoreCase) == 0
                select sr;

            // Collect all SIDs (which are licenses) for Web and DMV search results.
            // We ignore DLA results here as they contain something different
            // than license in SID property.
            var webDmvSids =
                from sr in searchResults
                where 
                    sr.Registry.Type != DonorRegistryType.Dla &&
                    !string.IsNullOrEmpty(sr.Person.Sid)
                select sr.Person.Sid;

            // If we have multiple different SIDs we
            // return all results (user will have to choose),
            // as this means they can represent different persons.
            if (webDmvSids.Distinct().Count() > 1)
            {
                return searchResults;
            }

            
            var dlaResults = searchResults.Where(sr => sr.Registry.Type == DonorRegistryType.Dla);

            // If we have multiple DLA results, return all 
            // results (user will have to choose).
            if (dlaResults.Count() > 1)
            {
                return searchResults;
            }

            // Otherwise get single latest search result.
            var filteredResults =
                from sr in searchResults
                orderby
                    sr.DonorDate descending,
                    GetSourcePriority(sr.Registry) descending
                select sr;

            return filteredResults.Take(1);
        }

        private int GetSourcePriority(DonorRegistryInfo source)
        {
            return source.Type switch
            {
                DonorRegistryType.Web => 1,
                DonorRegistryType.Dla => 2,
                DonorRegistryType.Dmv => 3,
                _ => default // This shouldn't ever happen
            };
        }

        #endregion Search

        #region Details
        public async Task<string> GetFormattedDonorDetailsAsync(
            int donorRegId,
            int donorDmvId,
            short donorDsnId)
        {
            var donorDetails = await GetDonorDetailsAsync(
                donorRegId,
                donorDmvId,
                donorDsnId).ConfigureAwait(false);

            string textMessage;

            if (donorDetails is null)
            {
                textMessage = "User no longer exists.  Please recheck the database.";
            }
            else
            {
                var donorName = donorDetails.Person.Name;
                var donorAddress = donorDetails.Person.Address;



                textMessage =
                    $"Donor Name: " +
                    $"{donorName.FirstName} {donorName.MiddleName} {donorName.LastName}" + Environment.NewLine +
                    $"DOB: {donorDetails.Person.DateOfBirth}" + Environment.NewLine +
                    $"Donor: {(donorDetails.OnRegistry ? "Y" : "N")}" + Environment.NewLine +
                    $"Address: {donorAddress.Address1} {donorAddress.Address2} " +
                    $"{donorAddress.City}, {donorAddress.State} {donorAddress.Zip}" + Environment.NewLine +
                    $"RenewalDate: {donorDetails.FlagDate}" + Environment.NewLine +
                    $"License/Registry: " +
                    // Don't pass the License/Registry value for DLA Registry donors
                    $"{(donorDetails.RegistryType == DonorRegistryType.Dla ? string.Empty : donorDetails.RegistryId)}" + Environment.NewLine +
                    $"Restrictions: {donorDetails.Restriction}";
            }

            return textMessage;
        }

        private async Task<DonorDetails?> GetDonorDetailsAsync(
            int donorRegId, 
            int donorDmvId,
            short donorDsnId)
        {
            string? registryOwnerState = null;
            DonorRegistryType registryType;
            int donorId;

            // For DLA source the ID is stored in both RegId and DmvId.
            if (donorRegId == donorDmvId & donorRegId != 0)
            {
                registryType = DonorRegistryType.Dla;
                donorId = donorRegId;
            }
            else
            // The order of checks for Reg/DMV source is the
            // same as was in the stored procedure (sps_GetRegistryData).
            if (donorDmvId != 0)
            {
                var config = await configurationProvider.GetConfigurationAsync().ConfigureAwait(false);
                
                registryOwnerState = config.DmvStateMapping.GetStateForDsnId(donorDsnId);

                registryType = DonorRegistryType.Dmv;
                donorId = donorDmvId;
            }
            else
            if (donorRegId != 0)
            {
                registryType = DonorRegistryType.Web;
                donorId = donorRegId;
            }
            else
            {
                throw new ArgumentException($"Both {nameof(donorRegId)} and {nameof(donorDmvId)} are 0.");
            }

            return await donorRegistry.GetDonorDetailsAsync(
                registryType, 
                registryOwnerState, 
                donorId).ConfigureAwait(false);
        }
        #endregion  Details
    }
}