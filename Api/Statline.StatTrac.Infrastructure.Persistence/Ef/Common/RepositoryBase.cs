using Microsoft.EntityFrameworkCore;
using System.Linq.Expressions;

namespace Statline.StatTrac.Infrastructure.Persistence.Ef.Common;

public abstract class RepositoryBase<TDbContext, TEntity>
        where TDbContext : DbContext
        where TEntity : class
{
    protected TDbContext DbContext { get; }
    protected DbSet<TEntity> EntitySet => DbContext.Set<TEntity>();

    protected RepositoryBase(TDbContext dbContext)
    {
        Check.NotNull(dbContext);
        DbContext = dbContext;

        // We currently don't need entity tracking, and won't need
        // while we're using stored procedures for inserts/updates.
        DbContext.ChangeTracker.QueryTrackingBehavior =
            QueryTrackingBehavior.NoTrackingWithIdentityResolution;
    }

    protected async Task<bool> AnyEntityExistsAsync(
       Expression<Func<TEntity, bool>> predicate)
    {
        Check.NotNull(predicate);

        return await EntitySet
            .TagWithCallerName()
            .AnyAsync(predicate)
            .ConfigureAwait(false);
    }

    protected IAsyncEnumerable<TResult> QueryEntities<TResult>(
        Expression<Func<TEntity, bool>> predicate,
        Expression<Func<TEntity, TResult>> selector)
    {
        Check.NotNull(predicate);
        Check.NotNull(selector);

        var results = EntitySet
            .TagWithCallerName()
            .Where(predicate)
            .Select(selector);

        return results.AsAsyncEnumerable();
    }

    protected async Task<TEntity?> FindEntityByIdAsync<TId>(TId id)
    {
        return await EntitySet
            .FindAsync(id)
            .ConfigureAwait(false);
    }
}
