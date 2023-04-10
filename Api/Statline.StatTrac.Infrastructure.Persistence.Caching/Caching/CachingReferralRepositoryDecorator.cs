using Statline.Common.Services;
using Statline.Common.Utilities;
using Statline.StatTrac.App.ReferralProcessor;
using Statline.StatTrac.Domain.Referrals;
using System.Linq.Expressions;

#nullable enable

namespace Statline.StatTrac.Infrastructure.Persistence.Composite;

/// <summary>
/// Different repositories support the set of operations 
/// required by <see cref="IReferralRepository "/> only partially.
/// This repository combines them so all operations are available
/// to consumers.
/// </summary>
public class CachingReferralRepositoryDecorator : IReferralRepository
{
    private readonly IReferralRepository mainRepository;
    private readonly IUpdatedReferralRepository recentlyUpdatedRepository;

    public CachingReferralRepositoryDecorator(
        IReferralRepository mainRepository,
        IUpdatedReferralRepository recentlyUpdatedRepository,
        IDateTimeService dateTimeService)
    {
        Check.NotNull(mainRepository, nameof(mainRepository));
        Check.NotNull(recentlyUpdatedRepository, nameof(recentlyUpdatedRepository));
        Check.NotNull(dateTimeService, nameof(dateTimeService));

        this.mainRepository = mainRepository;
        this.recentlyUpdatedRepository = recentlyUpdatedRepository;
    }

    public async Task<ReferralDetails?> GetDetailsByIdAsync(ReferralId referralId)
    {
        // TODO: We don't use this caching functionality anymore.
        // The application should be refactored to remove this composite
        // repository.

        // Here we use cache pattern.
        var referral =
            await recentlyUpdatedRepository.GetDetailsByIdAsync(referralId).ConfigureAwait(false);

        if (referral == null)
        {
            referral = await mainRepository.GetDetailsByIdAsync(referralId).ConfigureAwait(false);
        }

        return referral;
    }

    public async Task<IEnumerable<ReferralId>> GetUpdatedAsync(DateTimeOffset sinceTime)
    {
        return await recentlyUpdatedRepository.GetUpdatedAsync(sinceTime).ConfigureAwait(false);
    }

    public async Task<IEnumerable<ReferralId>> GetUpdatedAsync(
        DateTimeOffset from,
        DateTimeOffset to)
    {
        return await mainRepository.GetUpdatedAsync(from, to).ConfigureAwait(false);
    }

    public async Task<IEnumerable<ReferralId>> GetWithCallsInDateRangeAsync(
        DateTimeOffset from,
        DateTimeOffset to)
    {
        return await mainRepository.GetWithCallsInDateRangeAsync(from, to).ConfigureAwait(false);
    }

    public IAsyncEnumerable<ReferralId> GetDuplicateReferrals(
        DuplicateReferralsFilterCriteria filterCriteria)
    {
        return mainRepository.GetDuplicateReferrals(filterCriteria);
    }

    public async Task AddReferralAsync(Referral referral)
    {
        await mainRepository.AddReferralAsync(referral).ConfigureAwait(false);
    }

    public async Task<TResult?> FindReferralByIdAsync<TResult>(
        ReferralId id,
        Expression<Func<Referral, TResult>> selector) where TResult : notnull
    {
        return await mainRepository.FindReferralByIdAsync(id, selector).ConfigureAwait(false);
    }
}
