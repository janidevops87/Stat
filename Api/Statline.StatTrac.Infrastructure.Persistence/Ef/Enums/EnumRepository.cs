using Microsoft.EntityFrameworkCore;
using Statline.Common.Utilities;
using Statline.StatTrac.Domain.Common;
using Statline.StatTrac.Domain.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;

namespace Statline.StatTrac.Infrastructure.Persistence.Ef.Enums;

public class EnumRepository<TEnumEntity> : IEnumRepository<TEnumEntity>
    where TEnumEntity : class
{
    private readonly ReferralTransactionalDbContext referralDbContext;

    public EnumRepository(
        ReferralTransactionalDbContext referralDbContext)
    {
        this.referralDbContext = referralDbContext;
    }

    public IAsyncEnumerable<TResult> GetEnumValues<TResult>(
        Expression<Func<TEnumEntity, TResult>> selector)
    {
        Check.NotNull(selector);

        var values = referralDbContext.Set<TEnumEntity>()
            .TagWithCallerName()
            .AsNoTracking()
            .Select(selector);

        return values.AsAsyncEnumerable();
    }

    public IAsyncEnumerable<TResult> GetEnumValuesOrdered<TResult, TOrderKey>(
        Expression<Func<TEnumEntity, TResult>> selector,
        Expression<Func<TEnumEntity, TOrderKey>> orderKeySelector,
        Ordering ordering = Ordering.Ascending)
    {
        Check.NotNull(selector);
        Check.NotNull(orderKeySelector);

        var query = referralDbContext
            .Set<TEnumEntity>()
            .TagWithCallerName()
            .AsNoTracking();

        query = ordering == Ordering.Ascending ?
            query.OrderBy(orderKeySelector) :
            query.OrderByDescending(orderKeySelector);

        var values = query.Select(selector);

        return values.AsAsyncEnumerable();
    }

    public IAsyncEnumerable<TResult> QueryEnumValues<TResult>(
        Expression<Func<TEnumEntity, bool>> predicate,
        Expression<Func<TEnumEntity, TResult>> selector)
    {
        Check.NotNull(predicate);
        Check.NotNull(selector);

        var values = referralDbContext.Set<TEnumEntity>()
            .TagWithCallerName()
            .AsNoTracking()
            .Where(predicate)
            .Select(selector);

        return values.AsAsyncEnumerable();
    }

    public async Task<bool> AnyEnumValueExistsAsync(
        Expression<Func<TEnumEntity, bool>> predicate)
    {
        Check.NotNull(predicate);

        return await referralDbContext
            .Set<TEnumEntity>()
            .TagWithCallerName()
            .AnyAsync(predicate)
            .ConfigureAwait(false);
    }
}
