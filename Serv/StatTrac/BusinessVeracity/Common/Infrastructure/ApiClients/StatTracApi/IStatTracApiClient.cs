using Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ApiClients.StatTracApi.Dto;

namespace Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ApiClients.StatTracApi;

public interface IStatTracApiClient
{
    Task<ReferralDetails?> GetReferralDetailsAsync(int referralId, CancellationToken cancellationToken = default);
    Task<CallTimings> GetCallTimingsAsync(int callId, CancellationToken cancellationToken = default);
    Task<ICollection<HighRiskCallReferral>> GetHighRiskCallReferralsAsync(
        DateTimeOffset from,
        DateTimeOffset to,
        CancellationToken cancellationToken = default);
    Task<ICollection<int>> GetUpdatedReferrals(
           DateTimeOffset from,
           DateTimeOffset to,
           CancellationToken cancellationToken = default);
}
