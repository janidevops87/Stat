using Microsoft.EntityFrameworkCore;
using Statline.StatTrac.Domain.SubLocations;
using Statline.StatTrac.Infrastructure.Persistence.Ef.Common;
using System.Linq.Expressions;

namespace Statline.StatTrac.Infrastructure.Persistence.Ef.SubLocations;

public class SubLocationRepository :
    RepositoryBase<ReferralTransactionalDbContext, SubLocation>,
    ISubLocationRepository
{
    public SubLocationRepository(
        ReferralTransactionalDbContext dbContext)
        : base(dbContext)
    {
    }

    public async Task<bool> AnySubLocationExistsAsync(
        Expression<Func<SubLocation, bool>> predicate) =>
        await AnyEntityExistsAsync(predicate).ConfigureAwait(false);

    public async Task<SubLocation?> FindSubLocationByIdAsync(SubLocationId id) =>
        await FindEntityByIdAsync(id.Value).ConfigureAwait(false);

    public async Task<SubLocation?> FindSubLocationByNameAsync(string name)
    {
        Check.NotEmpty(name);

        return await EntitySet
            .TagWithCallerName()
            .Where(sl => sl.SubLocationName == name)
            .FirstOrDefaultAsync();
    }

    public IAsyncEnumerable<TResult> QuerySubLocations<TResult>(
        Expression<Func<SubLocation, bool>> predicate,
        Expression<Func<SubLocation, TResult>> selector) =>
        QueryEntities(predicate, selector);
}
