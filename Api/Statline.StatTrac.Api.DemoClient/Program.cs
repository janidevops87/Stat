using Newtonsoft.Json;
using Statline.StatTrac.Api.DemoClient.Http;
using Statline.StatTrac.Api.DemoClient.RestClient;
using System;
using System.Linq;
using System.Threading.Tasks;

namespace Statline.StatTrac.Api.DemoClient
{
    class Program
    {
        static async Task Main(string[] args)
        {

            var apiServerUrl = new Uri("https://statracapi-t.azurewebsites.net/");

            // This app uses "client credentials grant" OAuth 2.0 flow
            // (see https://tools.ietf.org/html/rfc6749#section-4.4).
            // This flow is intended for "native" apps which run as a system service
            // or similar. Important point is that app obtains access token
            // directly from token endpoint, authenticating with its 
            // credentials (ID and secret). This means that no user is 
            // involved in this scenario, and no external authorization
            // via Google, MS, FB etc. is possible.
            // 
            // To implement authorization which involves user in a non-browser application 
            // much more work is needed, since usually it requires hosting 
            // a browser frame which loads login page etc. This is especially 
            // the case for external authorization providers (Google, MS etc.).
            var authOptions = new ClientCredentialsAuthenticationOptions
            {
                ClientId = "testClient",
                ClientSecret = "testSecret",
                TokenEndpointAddress = "https://stidsrv-t.azurewebsites.net/connect/token",
                Scope = "statline.stattrac.api"
            };

            // Note: client instance should be shared within whole app
            // to avoid performance issues. Creating HttpClient and setting up 
            // new connections on every request is pretty expensive.
            // More: https://aspnetmonsters.com/2016/08/2016-08-27-httpclientwrong/.
            using (var authProvider = new ClientCredentialsAuthenticationProvider(authOptions))
            using (var client = new StatTracApiClient(apiServerUrl, authProvider))
            {
                Console.WriteLine("================================================");

                await DemoGetReferralsByCallDateTime(client);

                WaitForKeyPress("Press any key to go to the next demo...");

                Console.WriteLine("================================================");

                await DemoGetUpdatedReferrals(client);

                Console.WriteLine("================================================");
            }
        }

        static async Task DemoGetReferralsByCallDateTime(StatTracApiClient client)
        {
            var toTime = DateTimeOffset.Now;
            var fromTime = toTime.Subtract(TimeSpan.FromDays(5));

            Console.WriteLine($"Getting referrals with calls in date range [{fromTime}, {toTime}]...");

            var referralIds = await client.GetReferralsByCallDateTimeAsync(fromTime, toTime);

            Console.WriteLine($"Got following referral IDs:");
            Console.WriteLine(FormatToJson(referralIds));
          
        }

        static async Task DemoGetUpdatedReferrals(StatTracApiClient client)
        {
            var sinceTime = DateTimeOffset.Now.Subtract(TimeSpan.FromDays(5));

            Console.WriteLine($"Getting referrals updated since {sinceTime}...");

            var referralIds = await client.GetUpdatedReferralsAsync(sinceTime);

            Console.WriteLine();
            Console.WriteLine($"Got following referral IDs:");
            Console.WriteLine(FormatToJson(referralIds));

            if (!referralIds.Any())
            {
                return;
            }

            WaitForKeyPress("Press any key to iterate through each referral...");
            
            Console.WriteLine();
            Console.WriteLine($"Now will dump each referral details.");
            Console.WriteLine();

            foreach (int referralId in referralIds)
            {
                Console.WriteLine($"------------ Referral ID: {referralId} ------------");
                var referral = await client.GetReferralDetailsAsync(referralId);
                Console.WriteLine(FormatToJson(referral));

                WaitForKeyPress("Press any key to continue...");
            }
        }

        private static void WaitForKeyPress(string message)
        {
            Console.WriteLine();
            Console.WriteLine(message);
            Console.WriteLine();
            Console.ReadKey(intercept: true);
        }

        static string FormatToJson(object obj)
        {
            return JsonConvert.SerializeObject(obj, Formatting.Indented);
        }
    }
}
