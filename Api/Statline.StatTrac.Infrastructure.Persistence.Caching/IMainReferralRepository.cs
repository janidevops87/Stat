using Statline.StatTrac.Domain.Referrals;
using System.Linq.Expressions;

#nullable enable

namespace Statline.StatTrac.Infrastructure.Persistence;

public interface IMainReferralRepository
{
    Task<IEnumerable<ReferralId>> GetWithCallsInDateRangeAsync(
       DateTimeOffset from,
       DateTimeOffset to);
    Task<IEnumerable<ReferralId>> GetUpdatedAsync(DateTimeOffset from, DateTimeOffset to);
    Task<ReferralDetails?> GetDetailsByIdAsync(ReferralId referralId);
    IAsyncEnumerable<ReferralId> GetDuplicateReferrals(
        DuplicateReferralsFilterCriteria filterCriteria);
    Task AddReferralAsync(Referral referral);
    Task<TResult?> FindReferralAsync<TResult>(
        ReferralId id,
        Expression<Func<Referral, TResult>> selector) where TResult : notnull;
}
