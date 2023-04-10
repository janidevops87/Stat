using Statline.StatTrac.Domain.Common;
using System.Linq.Expressions;

namespace Statline.StatTrac.Domain.Persons;

public interface IPersonRepository
{
    Task<bool> AnyEmployeeExistsAsync(
      Expression<Func<StatEmployee, bool>> predicate);

    IAsyncEnumerable<StatEmployee> QueryEmployees(
        Expression<Func<StatEmployee, bool>> predicate);

    IAsyncEnumerable<TResult> QueryEmployees<TResult>(
        Expression<Func<StatEmployee, bool>> predicate,
        Expression<Func<StatEmployee, TResult>> selector);

    IAsyncEnumerable<TResult> QueryEmployeesOrdered<TResult, TOrderKey>(
        Expression<Func<StatEmployee, bool>> predicate,
        Expression<Func<StatEmployee, TResult>> selector,
        params (Expression<Func<StatEmployee, object?>> orderKeySelector, Ordering ordering)[] orderingInfos);

    IAsyncEnumerable<Person> QueryPersons(
        Expression<Func<Person, bool>> predicate);

    IAsyncEnumerable<TResult> QueryPersons<TResult>(
        Expression<Func<Person, bool>> predicate,
        Expression<Func<Person, TResult>> selector);

    IAsyncEnumerable<TResult> QueryPersonsOrdered<TResult>(
        Expression<Func<Person, bool>> predicate,
        Expression<Func<Person, TResult>> selector,
        params (Expression<Func<Person, object?>> orderKeySelector, Ordering ordering)[] orderingInfos);

    Task<TResult?> FindPersonByIdAsync<TResult>(
        int id,
        Expression<Func<Person, TResult>> selector)
        where TResult : notnull;

    Task AddPersonAsync(Person person);
}
