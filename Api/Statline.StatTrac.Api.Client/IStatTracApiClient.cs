using Statline.StatTrac.Api.Client.Dto.Persons.Filtered;
using Statline.StatTrac.Api.Client.Dto.Phones.Filtered;

namespace Statline.StatTrac.Api.Client;

public interface IStatTracApiClient
{
    Task<Dto.Referrals.NewReferral.CreatedReferral> AddReferralAsync(
        Dto.Referrals.NewReferral.Referral referral,
        CancellationToken token = default);
    Task<int> AddLogEventAsync(
        Dto.LogEvents.NewLogEvent.LogEvent logEvent,
        CancellationToken token = default);
    Task<int> AddReferralLogEventAsync(
        int referralId,
        Dto.LogEvents.NewLogEvent.ReferralLogEvent logEvent,
        CancellationToken token = default);
    Task<int> AddOrganizationPersonAsync(
        int organizationId,
        Dto.Persons.NewPerson.Person person,
        CancellationToken token = default);
    Task<ICollection<int>> GetFilteredOrganizationPersonIdsAsync(
        int organizationId,
        PersonFilterCriteria filterCriteria,
        bool ordered = false,
        CancellationToken token = default);
    Task<int> AddOrganizationPhoneAsync(
        int organizationId,
        Dto.Phones.NewPhone.OrganizationPhone phone,
        CancellationToken token = default);
    Task<ICollection<int>> GetFilteredOrganizationPhoneIdsAsync(
        int organizationId,
        PhoneFilterCriteria filterCriteria,
        CancellationToken token = default);
}
