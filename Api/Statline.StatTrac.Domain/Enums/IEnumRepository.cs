using Statline.StatTrac.Domain.Common;
using System.Linq.Expressions;

namespace Statline.StatTrac.Domain.Enums;

/// <summary>
/// Provides access to different entities which represent 
/// collections of values (enumerations). 
/// </summary>
/// <dev>
/// Note that these entities may be included into other entities.
/// I'm not sure yet if this is a good idea or we should have separate
/// copy of the entity class for each case of inclusion in other aggregate
/// entity.
/// </dev>
public interface IEnumRepository<TEnumEntity> where TEnumEntity : class
{
    IAsyncEnumerable<TResult> GetEnumValues<TResult>(
        Expression<Func<TEnumEntity, TResult>> selector);

    IAsyncEnumerable<TResult> GetEnumValuesOrdered<TResult, TOrderKey>(
        Expression<Func<TEnumEntity, TResult>> selector,
        Expression<Func<TEnumEntity, TOrderKey>> orderKeySelector,
        Ordering ordering = Ordering.Ascending);

    IAsyncEnumerable<TResult> QueryEnumValues<TResult>(
        Expression<Func<TEnumEntity, bool>> predicate,
        Expression<Func<TEnumEntity, TResult>> selector);

    Task<bool> AnyEnumValueExistsAsync(
        Expression<Func<TEnumEntity, bool>> predicate);
}
