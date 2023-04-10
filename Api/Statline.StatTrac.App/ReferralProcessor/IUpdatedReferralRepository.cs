using Statline.StatTrac.Domain.Referrals;

namespace Statline.StatTrac.App.ReferralProcessor;

public interface IUpdatedReferralRepository
{
    Task<IEnumerable<ReferralId>> GetUpdatedAsync(DateTimeOffset sinceTime);
    Task<ReferralDetails?> GetDetailsByIdAsync(ReferralId referralId);
    Task AddAsync(ReferralDetails referral);
    Task UpdateAsync(ReferralDetails referral);
    Task DeleteAsync(ReferralId referralId);
    Task DeleteAsync(ReferralDetails referral);
}
