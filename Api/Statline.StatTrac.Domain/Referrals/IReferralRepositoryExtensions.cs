using Statline.Common.Repository;
using System.Linq.Expressions;

namespace Statline.StatTrac.Domain.Referrals;

public static class IReferralRepositoryExtensions
{
    public static async Task<TResult> GetReferralByIdAsync<TResult>(
        this IReferralRepository repository,
        ReferralId id, 
        Expression<Func<Referral, TResult>> selector)
        where TResult : notnull
    {
        Check.NotNull(repository);
        
        var foundReferral = await repository.FindReferralByIdAsync(id, selector);

        if (foundReferral is null)
        {
            throw new EntityDoesntExistException($"Referral with id '{id}' doesn't exist");
        }

        return foundReferral;
    }
}
