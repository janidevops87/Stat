using Statline.Common.Infrastructure.Networking.RestClient;
using Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ApiClients.StatTracApi.Dto;
using System.Globalization;
using System.Net;

namespace Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ApiClients.StatTracApi;

internal class StatTracApiClient :
    RestServiceClient<StatTracApiClient>,
    IStatTracApiClient
{
    private const string BasePath = "api/v1.0/";

    public StatTracApiClient(
        HttpClient httpClient,
        IOptions<RestServiceClientOptions<StatTracApiClient>> options) :
        base(httpClient, BasePath, options)
    {
    }

    public async Task<CallTimings> GetCallTimingsAsync(int callId, CancellationToken cancellationToken)
    {
        var uri = new Uri(
            $"QAProcessor/calls/{callId.ToString(CultureInfo.InvariantCulture)}/timings", UriKind.Relative);

        return await HttpClient.SendAndUnwrapResultContentAsync<CallTimings>(
             uri,
             HttpMethod.Get,
             cancellationToken: cancellationToken).ConfigureAwait(false);
    }

    public async Task<ICollection<HighRiskCallReferral>> GetHighRiskCallReferralsAsync(
        DateTimeOffset from,
        DateTimeOffset to,
        CancellationToken cancellationToken)
    {
        var uri = BuildRequestUri(
            $"QAProcessor/referrals/with-high-risk-calls",
            new { from, to });

        return await HttpClient.SendAndUnwrapResultContentAsync<ICollection<HighRiskCallReferral>>(
             uri,
             HttpMethod.Get,
             cancellationToken: cancellationToken).ConfigureAwait(false);
    }

    public async Task<ReferralDetails?> GetReferralDetailsAsync(int referralId, CancellationToken cancellationToken)
    {
        var uri = new Uri(
            $"referrals/{referralId.ToString(CultureInfo.InvariantCulture)}/details", UriKind.Relative);

        try
        {
            return await HttpClient.SendAndUnwrapResultContentAsync<ReferralDetails>(
                 uri,
                 HttpMethod.Get,
                 cancellationToken: cancellationToken).ConfigureAwait(false);
        }
        catch (HttpRequestException ex) when (ex.StatusCode == HttpStatusCode.NotFound)
        {
            return null;
        }
    }

    public async Task<ICollection<int>> GetUpdatedReferrals(
       DateTimeOffset from,
       DateTimeOffset to,
       CancellationToken cancellationToken)
    {
        var uri = BuildRequestUri(
            $"referrals/updated",
            new { from, to });

        return await HttpClient.SendAndUnwrapResultContentAsync<ICollection<int>>(
             uri,
             HttpMethod.Get,
             cancellationToken: cancellationToken).ConfigureAwait(false);
    }
}
