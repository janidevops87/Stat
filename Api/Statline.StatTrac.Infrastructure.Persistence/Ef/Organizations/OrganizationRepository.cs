using Microsoft.EntityFrameworkCore;
using Statline.Common.Utilities;
using Statline.StatTrac.Domain.Organizations;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;

namespace Statline.StatTrac.Infrastructure.Persistence.Ef.Organizations;

public class OrganizationRepository : IOrganizationRepository
{
    private readonly ReferralTransactionalDbContext referralDbContext;

    public OrganizationRepository(
        ReferralTransactionalDbContext referralDbContext)
    {
        this.referralDbContext = referralDbContext;
    }

    public IAsyncEnumerable<Organization> QueryOrganizations(
        Expression<Func<Organization, bool>> predicate)
    {
        var employees = referralDbContext.Organizations
            .TagWithCallerName()
            .AsNoTracking()
            .Where(predicate);

        return employees.AsAsyncEnumerable();
    }

    public IAsyncEnumerable<TResult> QueryOrganizations<TResult>(
        Expression<Func<Organization, bool>> predicate,
        Expression<Func<Organization, TResult>> selector)
    {
        var results = referralDbContext.Organizations
            .TagWithCallerName()
            .AsNoTracking()
            .Where(predicate)
            .Select(selector);

        return results.AsAsyncEnumerable();
    }

    public async Task<TResult?> FindOrganizationByIdAsync<TResult>(
        OrganizationId id,
        Expression<Func<Organization, TResult>> selector) where TResult : notnull
    {
        Check.NotNull(selector, nameof(selector));

        return await referralDbContext.Organizations
            .TagWithCallerName()
            .AsNoTracking()
            .Where(org => org.OrganizationId == id.Value)
            .Select(selector)
            .SingleOrDefaultAsync()
            .ConfigureAwait(false);
    }

    public async Task<bool> AnyOrganizationExistsAsync(
        Expression<Func<Organization, bool>> predicate)
    {
        Check.NotNull(predicate);

        return await referralDbContext.Organizations
            .TagWithCallerName()
            .AnyAsync(predicate)
            .ConfigureAwait(false);
    }
}
