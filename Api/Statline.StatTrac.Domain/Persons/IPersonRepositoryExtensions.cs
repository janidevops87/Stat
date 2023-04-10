using Statline.Common.Repository;
using Statline.StatTrac.Domain.Common;
using Statline.StatTrac.Domain.Organizations;
using System.Linq;
using System.Linq.Expressions;

namespace Statline.StatTrac.Domain.Persons;

public static class IPersonRepositoryExtensions
{
    public static async Task<bool> EmployeeWithIdExistsAsync(
       this IPersonRepository personRepository,
       int employeeId)
    {
        return await Check.NotNull(personRepository)
            .AnyEmployeeExistsAsync(r => r.StatEmployeeId == employeeId);
    }

    /// <summary>
    /// Checks if an employee with the given ID <paramref name="employeeId"/> exists
    /// and throws <see cref="InvalidInputDataException"/> if not.
    /// </summary>
    /// <remarks>
    /// Use this employee check when the <paramref name="employeeId"/> is part of
    /// input data and the identified employee is not the main entity to be operated on
    /// and is not logical parent of such entity.
    /// </remarks>
    public static async Task ValidateEmployeeIdAsync(
        this IPersonRepository personRepository,
        int employeeId)
    {
        var employeeExists = await personRepository.EmployeeWithIdExistsAsync(employeeId);

        if (!employeeExists)
        {
            throw new InvalidInputDataException($"Employee with id '{employeeId}' wasn't found.");
        }
    }

    public static IAsyncEnumerable<TResult> GetFilteredEmployeePersons<TResult>(
        this IPersonRepository personRepository,
        EmployeeFilterCriteria filterCriteria,
        Expression<Func<Person, TResult>> selector)
    {
        Check.NotNull(personRepository, nameof(personRepository));
        Check.NotNull(filterCriteria, nameof(filterCriteria));
        Check.NotNull(selector, nameof(selector));

        return personRepository.QueryPersons(
            PredicateFromEmployeeFilterCriteria(filterCriteria),
            selector);
    }

    public static async Task<PersonId?> FindPersonIdByNameAsync(
        this IPersonRepository personRepository,
        PersonName personName,
        OrganizationId organizationId)
    {
        Check.NotNull(personRepository);
        Check.NotNull(personName);

        return await personRepository.GetFilteredPersonsOrdered(
            filterCriteria: new PersonFilterCriteria
            (
                FirstName: personName.FirstName,
                LastName: personName.LastName,
                ActiveState: ActiveStateFilter.ActiveOnly,
                OrganizationId: organizationId
            ),
            selector: person => (PersonId?)person.PersonId,
            // NOTE: Here we simplify life to ourselves
            // and assume Inactive can only be 0 or 1,
            // relying on filtering predicate.
            (p => p.Inactive, Ordering.Ascending),
            (p => p.PersonFirst, Ordering.Ascending),
            (p => p.PersonLast, Ordering.Ascending))
            .FirstOrDefaultAsync();
    }

    public static async Task<TResult> GetPersonByIdAsync<TResult>(
        this IPersonRepository personRepository,
        int id,
        Expression<Func<Person, TResult>> selector)
        where TResult : notnull
    {
        Check.NotNull(personRepository);

        var foundPerson = await personRepository.FindPersonByIdAsync(id, selector);

        if (foundPerson is null)
        {
            throw new EntityDoesntExistException($"Person with id '{id}' doesn't exist");
        }

        return foundPerson;
    }

    public static IAsyncEnumerable<TResult> GetFilteredPersons<TResult>(
        this IPersonRepository personRepository,
        PersonFilterCriteria filterCriteria,
        Expression<Func<Person, TResult>> selector)
    {
        Check.NotNull(personRepository, nameof(personRepository));
        Check.NotNull(filterCriteria, nameof(filterCriteria));
        Check.NotNull(selector, nameof(selector));

        return personRepository.QueryPersons(
            PredicateFromPersonFilterCriteria(filterCriteria),
            selector);
    }

    public static IAsyncEnumerable<TResult> GetFilteredPersonsOrdered<TResult>(
        this IPersonRepository personRepository,
        PersonFilterCriteria filterCriteria,
        Expression<Func<Person, TResult>> selector,
        params (Expression<Func<Person, object?>> orderKeySelector, Ordering ordering)[] orderingInfos)
    {
        Check.NotNull(personRepository, nameof(personRepository));
        Check.NotNull(filterCriteria, nameof(filterCriteria));
        Check.NotNull(selector, nameof(selector));

        return personRepository.QueryPersonsOrdered(
            PredicateFromPersonFilterCriteria(filterCriteria),
            selector,
            orderingInfos);
    }

    private static Expression<Func<Person, bool>> PredicateFromEmployeeFilterCriteria(
       EmployeeFilterCriteria filterCriteria)
    {
        return person =>
            person.StatEmployee != null && // Possibly not needed, but just to be sure (doesn't hurt performance)
            (filterCriteria.FirstName == null || person.StatEmployee!.StatEmployeeFirstName == filterCriteria.FirstName) &&
            (filterCriteria.LastName == null || person.StatEmployee!.StatEmployeeLastName == filterCriteria.LastName) &&
            // Formal rule:
            // 0 = false (active),
            // null = false (active),
            // any other value(inc. -1) = true (inactive)
            (filterCriteria.ActiveState == ActiveStateFilter.ActiveAndInactive ||
                (
                    (person.Inactive == IntegerBoolean.OneTrue ||
                    person.Inactive == IntegerBoolean.MinusOneTrue) ==
                    (filterCriteria.ActiveState == ActiveStateFilter.InactiveOnly)
                )
            );
    }

    private static Expression<Func<Person, bool>> PredicateFromPersonFilterCriteria(
        PersonFilterCriteria filterCriteria)
    {
        int? filterCriteriaOrganizationId = filterCriteria.OrganizationId;

        return person =>
            (filterCriteria.FirstName == null || person.PersonFirst == filterCriteria.FirstName) &&
            (filterCriteria.LastName == null || person.PersonLast == filterCriteria.LastName) &&
            (filterCriteria.OrganizationId == null || person.OrganizationId == filterCriteriaOrganizationId) &&
            // Formal rule:
            // 0 = false (active),
            // null = false (active),
            // any other value(inc. -1) = true (inactive)
            (filterCriteria.ActiveState == ActiveStateFilter.ActiveAndInactive ||
                (
                    (person.Inactive == IntegerBoolean.OneTrue ||
                    person.Inactive == IntegerBoolean.MinusOneTrue) ==
                    (filterCriteria.ActiveState == ActiveStateFilter.InactiveOnly)
                )
            );
    }
}