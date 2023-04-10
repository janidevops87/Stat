using System.Linq.Expressions;

namespace Statline.StatTrac.Domain.SubLocations;

public interface ISubLocationRepository
{
    Task<SubLocation?> FindSubLocationByIdAsync(SubLocationId id);
    Task<SubLocation?> FindSubLocationByNameAsync(string name);

    IAsyncEnumerable<TResult> QuerySubLocations<TResult>(
        Expression<Func<SubLocation, bool>> predicate,
        Expression<Func<SubLocation, TResult>> selector);

    Task<bool> AnySubLocationExistsAsync(
        Expression<Func<SubLocation, bool>> predicate);
}
