using System.Linq.Expressions;

namespace Statline.StatTrac.Domain.Referrals;

public interface IReferralRepository
{
    Task<IEnumerable<ReferralId>> GetWithCallsInDateRangeAsync(
        DateTimeOffset from,
        DateTimeOffset to);

    Task<IEnumerable<ReferralId>> GetUpdatedAsync(DateTimeOffset from, DateTimeOffset to);

    Task<ReferralDetails?> GetDetailsByIdAsync(ReferralId referralId);
    IAsyncEnumerable<ReferralId> GetDuplicateReferrals(
        DuplicateReferralsFilterCriteria filterCriteria);

    Task AddReferralAsync(Referral referral);
    Task<TResult?> FindReferralByIdAsync<TResult>(ReferralId id, Expression<Func<Referral, TResult>> selector)
        where TResult : notnull;
}
