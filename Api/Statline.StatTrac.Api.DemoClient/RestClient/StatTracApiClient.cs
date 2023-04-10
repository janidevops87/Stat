using Statline.StatTrac.Api.DemoClient.Http;
using Statline.StatTrac.Api.DemoClient.Model;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;

namespace Statline.StatTrac.Api.DemoClient.RestClient
{
    public class StatTracApiClient : RestServiceClient
    {
         const string BasePath = "api/v1.0/referrals/";

        public StatTracApiClient(
            Uri serverUrl,
            IAuthenticationProvider authProvider) :
            base(serverUrl, BasePath, authProvider)
        {
        }

        public async Task<IEnumerable<int>> GetUpdatedReferralsAsync(DateTimeOffset sinceTime)
        {
            var formattedDate = WebUtility.UrlEncode(sinceTime.ToString("o"));

            var uri = BuildRequestUri(
              path: "updated",
              parameters: new Dictionary<string, string>
              {
                  ["sinceTime"] = formattedDate
              });

            return await SendAsync<int[]>(uri, HttpMethod.Get).ConfigureAwait(false);
        }

        public async Task<IEnumerable<int>> GetReferralsByCallDateTimeAsync(
            DateTimeOffset from,
            DateTimeOffset to)
        {
            var formattedFrom = WebUtility.UrlEncode(from.ToString("o"));
            var formattedTo = WebUtility.UrlEncode(to.ToString("o"));

            var uri = BuildRequestUri(
              path: "bycalldatetime",
              parameters: new Dictionary<string, string>
              {
                  ["from"] = formattedFrom,
                  ["to"] = formattedTo,
              });

            return await SendAsync<int[]>(uri, HttpMethod.Get).ConfigureAwait(false);
        }

        public async Task<Referral> GetReferralDetailsAsync(int referralId)
        {
            var formattedReferralId = referralId.ToString(CultureInfo.InvariantCulture);

            var uri = new Uri(formattedReferralId, UriKind.Relative);

            return await SendAsync<Referral>(uri, HttpMethod.Get).ConfigureAwait(false);
        }
    }
}
