using System.Linq.Expressions;

namespace Statline.StatTrac.Domain.Phones;

public interface IPhoneRepository
{
    IAsyncEnumerable<TResult> QueryOrganizationPhones<TResult>(
        Expression<Func<OrganizationPhone, bool>> predicate,
        Expression<Func<OrganizationPhone, TResult>> selector);

    Task<bool> AnyOrganizationPhoneExistsAsync(
        Expression<Func<OrganizationPhone, bool>> predicate);

    Task AddPhoneAsync(Phone phone);
}
