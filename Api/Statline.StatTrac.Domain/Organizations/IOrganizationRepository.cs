using System.Linq.Expressions;

namespace Statline.StatTrac.Domain.Organizations;

public interface IOrganizationRepository
{
    Task<TResult?> FindOrganizationByIdAsync<TResult>(
        OrganizationId id,
        Expression<Func<Organization, TResult>> selector)
        where TResult : notnull;

    Task<bool> AnyOrganizationExistsAsync(
        Expression<Func<Organization, bool>> predicate);

    IAsyncEnumerable<Organization> QueryOrganizations(
        Expression<Func<Organization, bool>> predicate);

    IAsyncEnumerable<TResult> QueryOrganizations<TResult>(
        Expression<Func<Organization, bool>> predicate,
        Expression<Func<Organization, TResult>> selector);
}
