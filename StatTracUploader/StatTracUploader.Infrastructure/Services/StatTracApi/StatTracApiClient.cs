using Microsoft.Extensions.Options;
using Statline.Common.Infrastructure.Networking.RestClient;
using Statline.Common.Utilities;
using Statline.StatTracUploader.Infrastructure.Services.StatTracApi.Model.Calls;
using Statline.StatTracUploader.Infrastructure.Services.StatTracApi.Model.Enums;
using Statline.StatTracUploader.Infrastructure.Services.StatTracApi.Model.Heartbeat;
using Statline.StatTracUploader.Infrastructure.Services.StatTracApi.Model.LogEvents;
using Statline.StatTracUploader.Infrastructure.Services.StatTracApi.Model.Organizations;
using Statline.StatTracUploader.Infrastructure.Services.StatTracApi.Model.Persons;
using Statline.StatTracUploader.Infrastructure.Services.StatTracApi.Model.Referrals;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Threading;
using System.Threading.Tasks;

namespace Statline.StatTracUploader.Infrastructure.Services.StatTracApi
{
    internal class StatTracApiClient : RestServiceClient<StatTracApiClient>, IStatTracApiClient
    {
        const string BasePath = "api/v1.0/";

        public StatTracApiClient(
            HttpClient httpClient,
            IOptions<RestServiceClientOptions<StatTracApiClient>> options) :
            base(httpClient, BasePath, options)
        {
        }

        public async Task<ApiHealthReport> GetApiHealthReportAsync(CancellationToken cancellationToken)
        {
            var uri = new Uri("heartbeat", UriKind.Relative);

            return await HttpClient.SendAndUnwrapAsync<ApiHealthReport>(
                uri,
                HttpMethod.Get,
                cancellationToken: cancellationToken).ConfigureAwait(false);
        }

        public async Task<int> GetSourceCodeIdAsync(string sourceCode, CancellationToken cancellationToken)
        {
            Check.NotEmpty(sourceCode, nameof(sourceCode));

            var uri = BuildRequestUri("referrals/GetSourceCodeId", new { sourceCode });

            return await HttpClient.SendAndUnwrapAsync<int>(
                 uri,
                 HttpMethod.Get,
                 cancellationToken: cancellationToken).ConfigureAwait(false);
        }

        public async Task<ICollection<StatEmployee>> GetFilteredEmployeesAsync(
            string? firstName,
            string? lastName,
            bool? inactive,
            CancellationToken cancellationToken)
        {
            var uri = BuildRequestUri("employees/filtered", new { firstName, lastName, inactive });

            return await HttpClient.SendAndUnwrapAsync<ICollection<StatEmployee>>(
                 uri,
                 HttpMethod.Get,
                 cancellationToken: cancellationToken).ConfigureAwait(false);
        }

        public async Task<ICollection<int>> GetFilteredPersonIdsOrderedAsync(
            PersonFilterCriteria filterCriteria,
            CancellationToken cancellationToken)
        {
            var uri = BuildRequestUri("persons/filtered/ids",
                new 
                {
                    filterCriteria.FirstName,
                    filterCriteria.LastName,
                    filterCriteria.Inactive,
                    filterCriteria.OrganizationId,
                    Ordered = true
                });
            
            return await HttpClient.SendAndUnwrapAsync<ICollection<int>>(
                 uri,
                 HttpMethod.Get,
                 cancellationToken: cancellationToken).ConfigureAwait(false);
        }

        public async Task<ICollection<Organization>> GetFilteredOrganizationsAsync(
            OrganizationFilterCriteria filterCriteria,
            CancellationToken cancellationToken)
        {
            Check.NotNull(filterCriteria, nameof(filterCriteria));

            var uri = BuildRequestUri("organizations/filtered", filterCriteria);

            return await HttpClient.SendAndUnwrapAsync<ICollection<Organization>>(
                 uri,
                 HttpMethod.Get,
                 cancellationToken: cancellationToken).ConfigureAwait(false);
        }

        public async Task<ICollection<int>> GetFilteredOrganizationIdsAsync(
            OrganizationFilterCriteria filterCriteria,
            CancellationToken cancellationToken)
        {
            Check.NotNull(filterCriteria, nameof(filterCriteria));

            var uri = BuildRequestUri("organizations/filtered/ids", filterCriteria);

            return await HttpClient.SendAndUnwrapAsync<ICollection<int>>(
                 uri,
                 HttpMethod.Get,
                 cancellationToken: cancellationToken).ConfigureAwait(false);
        }

        public async Task<ICollection<SubLocation>> GetFilteredOrganizationSubLocationsAsync(
            int organizationId,
            SubLocationFilterCriteria filterCriteria,
            CancellationToken cancellationToken)
        {
            Check.NotNull(filterCriteria, nameof(filterCriteria));

            var uri = BuildRequestUri(
                $"organizations/{organizationId}/sublocations/filtered", filterCriteria);

            return await HttpClient.SendAndUnwrapAsync<ICollection<SubLocation>>(
                uri,
                HttpMethod.Get,
                cancellationToken: cancellationToken).ConfigureAwait(false);
        }

        public async Task<ICollection<int>> GetFilteredOrganizationPhoneIds(
            int organizationId, 
            PhoneFilterCriteria filterCriteria, 
            CancellationToken cancellationToken)
        {
            Check.NotNull(filterCriteria, nameof(filterCriteria));

            var uri = BuildRequestUri(
                $"organizations/{organizationId}/phones/filtered/ids", filterCriteria);

            return await HttpClient.SendAndUnwrapAsync<ICollection<int>>(
                uri,
                HttpMethod.Get,
                cancellationToken: cancellationToken).ConfigureAwait(false);
        }

        public async Task<ICollection<EnumValue>> GetAllCausesOfDeathAsync(
            CancellationToken cancellationToken)
        {
            return await HttpClient.SendAndUnwrapAsync<ICollection<EnumValue>>(
                new Uri("causesofdeath", UriKind.Relative),
                HttpMethod.Get,
                cancellationToken: cancellationToken).ConfigureAwait(false);
        }

        public async Task<ICollection<EnumValue>> GetAllRacesAsync(CancellationToken cancellationToken)
        {
            return await HttpClient.SendAndUnwrapAsync<ICollection<EnumValue>>(
                new Uri("races", UriKind.Relative),
                HttpMethod.Get,
                cancellationToken: cancellationToken).ConfigureAwait(false);
        }

        public async Task<ICollection<int>> GetDuplicateReferralIdsAsync(
            DuplicateReferralsFilterCriteria filterCriteria,
            CancellationToken cancellationToken)
        {
            Check.NotNull(filterCriteria, nameof(filterCriteria));

            var uri = BuildRequestUri("referrals/duplicate", filterCriteria);

            return await HttpClient.SendAndUnwrapAsync<ICollection<int>>(
                uri,
                HttpMethod.Get,
                cancellationToken: cancellationToken).ConfigureAwait(false);
        }

        public async Task<int> AddLogEventAsync(
            NewLogEvent logEvent, 
            CancellationToken cancellationToken)
        {
            Check.NotNull(logEvent, nameof(logEvent));

            // Note: Location header contains URI of the created
            // event resource according to HTTP 201 (Created) status code.

            return await HttpClient.SendAndUnwrapAsync<int>(
                new Uri("logevents", UriKind.Relative),
                HttpMethod.Post,
                content: logEvent,
                cancellationToken: cancellationToken).ConfigureAwait(false);
        }

        public async Task<int> AddReferralAsync(
            NewReferral referral, 
            CancellationToken cancellationToken)
        {
            Check.NotNull(referral, nameof(referral));

            // Note: Location header contains URI of the created
            // event resource according to HTTP 201 (Created) status code.

            return await HttpClient.SendAndUnwrapAsync<int>(
                new Uri("referrals", UriKind.Relative),
                HttpMethod.Post,
                content: referral,
                cancellationToken: cancellationToken).ConfigureAwait(false);
        }

        public async Task<int> AddCallAsync(NewCall call, CancellationToken cancellationToken)
        {
            Check.NotNull(call, nameof(call));

            // Note: Location header contains URI of the created
            // event resource according to HTTP 201 (Created) status code.

            return await HttpClient.SendAndUnwrapAsync<int>(
                new Uri("calls", UriKind.Relative),
                HttpMethod.Post,
                content: call,
                cancellationToken: cancellationToken).ConfigureAwait(false);

        }
    }
}
