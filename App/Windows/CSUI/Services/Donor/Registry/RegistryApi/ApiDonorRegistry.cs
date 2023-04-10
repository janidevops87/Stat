using Newtonsoft.Json;
using Statline.Common.Utilities;
using Statline.Stattrac.Framework;
using Statline.Registry.Api.Client;
using Stattrac.Services.Donor.Registry.Model;
using System;
using System.Linq;
using System.Threading.Tasks;

namespace Stattrac.Services.Donor.Registry.RegistryApi
{
    public class ApiDonorRegistry : IDonorRegistry
    {
        private readonly IRegistryApiClient registryApiClient;

        public ApiDonorRegistry(IRegistryApiClient registryApiClient)
        {
            Check.NotNull(registryApiClient, nameof(registryApiClient));
            this.registryApiClient = registryApiClient;
        }

        public async Task<Model.DonorDetails?> GetDonorDetailsAsync(
            DonorRegistryType registryType,
            string? registryOwnerState,
            int donorId)
        {
            Check.BiggerOrEqual(donorId, 0, nameof(donorId));

            var registryName = CommonConverter.RegistryTypeToRegistryName(registryType);
            var donorIdString = CommonConverter.IdToString(donorId);

            Statline.Registry.Api.Client.DonorDetails apiDonorDetails;

            try
            {
                apiDonorDetails = await ExecuteWithLogging(
                                   () => registryApiClient.GetDonorDetailsAsync(
                                       registryName,
                                       registryOwnerState,
                                       donorIdString)).ConfigureAwait(false);
            }
            catch (RegistryResourceNotFoundException)
            {
                return null;
            }

            return apiDonorDetails.ToModelDonorDetails();
        }



        public async Task<DonorSearchResult[]> SearchDonorsAsync(
            DonorSearchRequest donorSearchRequest, DonorSearchConfiguration config)
        {
            Check.NotNull(donorSearchRequest, nameof(donorSearchRequest));

            var apiResults = await SearchRegistryWithLogging(
                donorSearchRequest.ToSearchRequest(config)).ConfigureAwait(false);

            return apiResults.ToDonorSearchResults().ToArray();
        }

        private async Task<SearchResult[]> SearchRegistryWithLogging(SearchRequest request)
        {
            try
            {
                return await registryApiClient.SearchRegistryAsync(request).ConfigureAwait(false);
            }
            catch (RegistryApiException ex)
            {
                LogRegistryApiSearchError(request, ex);
                throw;
            }
            catch (Exception ex)
            {
                LogException(ex);
                throw;
            }
        }

        private async Task<TResult> ExecuteWithLogging<TResult>(Func<Task<TResult>> action)
        {
            try
            {
                return await action().ConfigureAwait(false);
            }
            catch (Exception ex)
            {
                LogException(ex);
                throw;
            }
        }

        private static void LogRegistryApiSearchError(
            SearchRequest request,
            RegistryApiException ex)
        {

            // Result is not included as there is no result in case of error.
            string description =
                "Donor Search Failure due to error returned from Registry API.  " +
                $"ErrorDescriptionFromAPI: {string.Join(", ", ex.ErrorDetails)} " +
                "SearchRequest: " + JsonConvert.SerializeObject(request, Formatting.Indented);

            LogException(new Exception(description, ex));
        }

        private static void LogException(Exception ex)
        {
            try
            {
                StatTracLogger.CreateInstance().Write(ex);
            }
            catch
            {
                // Swallow error
            }
        }


    }
}
