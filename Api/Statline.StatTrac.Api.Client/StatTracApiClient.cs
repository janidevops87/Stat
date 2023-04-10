using Statline.Common.Infrastructure.Networking.RestClient;
using Statline.StatTrac.Api.Client.Dto.LogEvents.NewLogEvent;
using Statline.StatTrac.Api.Client.Dto.Persons.Filtered;
using Statline.StatTrac.Api.Client.Dto.Phones.Filtered;
using Statline.StatTrac.Api.Client.Dto.Phones.NewPhone;
using Statline.StatTrac.Api.Client.Dto.Referrals.NewReferral;

namespace Statline.StatTrac.Api.Client;

internal class StatTracApiClient :
    RestServiceClient<StatTracApiClient>,
    IStatTracApiClient
{
    private const string BasePath = "api/v2.0/";

    public StatTracApiClient(
        HttpClient httpClient,
        IOptions<RestServiceClientOptions<StatTracApiClient>> options)
        : base(httpClient, BasePath, options)
    {
    }

    public async Task<CreatedReferral> AddReferralAsync(
        Referral referral,
        CancellationToken token)
    {
        Check.NotNull(referral);

        // Note: Location header contains URI of the created
        // referral resource according to HTTP 201 (Created) status code.

        return await HttpClient.SendAndUnwrapResultContentAsync<CreatedReferral>(
            new Uri("referrals", UriKind.Relative),
            HttpMethod.Post,
            content: referral,
            token).ConfigureAwait(false);
    }

    public async Task<int> AddLogEventAsync(
        LogEvent logEvent,
        CancellationToken token)
    {
        Check.NotNull(logEvent);

        // Note: Location header contains URI of the created
        // log event resource according to HTTP 201 (Created) status code.

        return await HttpClient.SendAndUnwrapResultContentAsync<int>(
            new Uri("logevents", UriKind.Relative),
            HttpMethod.Post,
            content: logEvent,
            token).ConfigureAwait(false);
    }

    public async Task<int> AddReferralLogEventAsync(
        int referralId,
        ReferralLogEvent logEvent,
        CancellationToken token)
    {
        Check.Bigger(referralId, 0);
        Check.NotNull(logEvent);

        // Note: Location header contains URI of the created
        // log event resource according to HTTP 201 (Created) status code.

        string path = FormattableString.Invariant($"referrals/{referralId}/logevents");

        return await HttpClient.SendAndUnwrapResultContentAsync<int>(
            new Uri(path, UriKind.Relative),
            HttpMethod.Post,
            content: logEvent,
            token).ConfigureAwait(false);
    }

    public async Task<int> AddOrganizationPersonAsync(
        int organizationId,
        Dto.Persons.NewPerson.Person person,
        CancellationToken token)
    {
        // Note: Location header contains URI of the created
        // person resource according to HTTP 201 (Created) status code.

        string path = FormattableString.Invariant($"organizations/{organizationId}/persons");

        return await HttpClient.SendAndUnwrapResultContentAsync<int>(
            new Uri(path, UriKind.Relative),
            HttpMethod.Post,
            content: person,
            token).ConfigureAwait(false);
    }

    public async Task<ICollection<int>> GetFilteredOrganizationPersonIdsAsync(
        int organizationId,
        PersonFilterCriteria filterCriteria,
        bool ordered,
        CancellationToken token)
    {
        Check.NotNull(filterCriteria);

        string path = FormattableString.Invariant($"organizations/{organizationId}/persons/filtered/ids");

        var uri = BuildRequestUri(path,
               new
               {
                   filterCriteria.FirstName,
                   filterCriteria.LastName,
                   filterCriteria.ActiveState,
                   Ordered = ordered
               });

        return await HttpClient.SendAndUnwrapResultContentAsync<ICollection<int>>(
            uri,
            HttpMethod.Get,
            content: null,
            token).ConfigureAwait(false);
    }

    public async Task<int> AddOrganizationPhoneAsync(
        int organizationId, 
        OrganizationPhone phone, 
        CancellationToken token)
    {
        // Note: Location header contains URI of the created
        // phone resource according to HTTP 201 (Created) status code.

        string path = FormattableString.Invariant($"organizations/{organizationId}/phones");

        return await HttpClient.SendAndUnwrapResultContentAsync<int>(
            new Uri(path, UriKind.Relative),
            HttpMethod.Post,
            content: phone,
            token).ConfigureAwait(false);
    }

    public async Task<ICollection<int>> GetFilteredOrganizationPhoneIdsAsync(
        int organizationId, 
        PhoneFilterCriteria filterCriteria, 
        CancellationToken token)
    {
        Check.NotNull(filterCriteria);

        string path = FormattableString.Invariant(
            $"organizations/{organizationId}/phones/filtered/ids");

        var uri = BuildRequestUri(path,
               new
               {
                   filterCriteria.PhoneNumber,
                   filterCriteria.ActiveState
               });

        return await HttpClient.SendAndUnwrapResultContentAsync<ICollection<int>>(
            uri,
            HttpMethod.Get,
            content: null,
            token).ConfigureAwait(false);
    }
}
