using System;
using System.Net.Http;
using System.Threading.Tasks;
using Microsoft.Extensions.Options;
using Statline.Common.Utilities;
using Statline.StatTrac.Api.Infrastructure.RestClient.Model;
using Statline.StatTrac.Api.Infrastructure.Http;

namespace Statline.StatTrac.Api.Infrastructure.RestClient
{
    internal class StatTracApiClient : RestServiceClient, IStatTracApiClient
    {
        const string BasePath = "api/v1.0/";

        public StatTracApiClient(
            IOptions<StatTracApiClientOptions> options,
            IAuthenticationProvider authProvider) :
            base(ValidateOptions(options).ServerUrl, BasePath, authProvider)
        {
        }

        private static StatTracApiClientOptions ValidateOptions(
            IOptions<StatTracApiClientOptions> options)
        {
            Check.NotNull(options, nameof(options));

            var optionsValue = options.Value;

            Check.NotNull(
                optionsValue.ServerUrl,
                nameof(options),
                nameof(optionsValue.ServerUrl));

            return optionsValue;
        }

        public async Task<ReferralProcessingResult> ProcessReferralAsync(ReferralInfo referralInfo)
        {
            Check.NotNull(referralInfo, nameof(referralInfo));

            return await SendAsync<ReferralProcessingResult>(
                new Uri("referrals/processor", UriKind.Relative),
                HttpMethod.Post,
                referralInfo).ConfigureAwait(false);
        }

        public async Task<ApiHealthReport> GetApiHealthReportAsync()
        {
            return await SendAsync<ApiHealthReport>(
                new Uri("heartbeat", UriKind.Relative),
                HttpMethod.Get).ConfigureAwait(false);
        }
    }
}
