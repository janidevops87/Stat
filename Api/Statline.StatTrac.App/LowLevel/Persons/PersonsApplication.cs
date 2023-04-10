using Statline.StatTrac.Domain.Common;
using Statline.StatTrac.Domain.Persons;
using System.Linq.Expressions;

namespace Statline.StatTrac.App.LowLevel.Persons;

public class PersonsApplication
{
    private readonly IPersonRepository personRepository;

    public PersonsApplication(IPersonRepository personRepository)
    {
        this.personRepository = Check.NotNull(personRepository, nameof(personRepository));
    }

    public IAsyncEnumerable<PersonInfo> GetFilteredPersons(PersonFilterCriteria filterCriteria)
    {
        Check.NotNull(filterCriteria, nameof(filterCriteria));

        return personRepository.GetFilteredPersons(filterCriteria, PersonSelector());
    }


    public IAsyncEnumerable<PersonInfo> GetFilteredPersonsOrdered(
        PersonFilterCriteria filterCriteria)
    {
        Check.NotNull(filterCriteria, nameof(filterCriteria));

        return personRepository.GetFilteredPersonsOrdered(
            filterCriteria,
            PersonSelector(),
            // NOTE: Here we simplify life to ourselves
            // and assume Inactive can only be 0 or 1,
            // relying on filtering predicate.
            (p => p.Inactive, Ordering.Ascending),
            (p => p.PersonFirst, Ordering.Ascending),
            (p => p.PersonLast, Ordering.Ascending));
    }

    public IAsyncEnumerable<int> GetFilteredPersonIds(PersonFilterCriteria filterCriteria)
    {
        Check.NotNull(filterCriteria, nameof(filterCriteria));

        return personRepository.GetFilteredPersons(
            filterCriteria,
            selector: person => person.PersonId.Value);
    }

    public IAsyncEnumerable<int> GetFilteredPersonIdsOrdered(
        PersonFilterCriteria filterCriteria)
    {
        Check.NotNull(filterCriteria, nameof(filterCriteria));

        return personRepository.GetFilteredPersonsOrdered(
            filterCriteria,
            selector: person => person.PersonId.Value,
            // NOTE: Here we simplify life to ourselves
            // and assume Inactive can only be 0 or 1,
            // relying on filtering predicate.
            (p => p.Inactive, Ordering.Ascending),
            (p => p.PersonFirst, Ordering.Ascending),
            (p => p.PersonLast, Ordering.Ascending));
    }

    public IAsyncEnumerable<StatEmployeeInfo> GetFilteredEmployees(
        EmployeeFilterCriteria filterCriteria)
    {
        Check.NotNull(filterCriteria, nameof(filterCriteria));

        return personRepository.GetFilteredEmployeePersons(
            filterCriteria,
            selector: person => new StatEmployeeInfo(
                    person.StatEmployee!.StatEmployeeId,
                    person.StatEmployee!.StatEmployeeFirstName,
                    person.StatEmployee!.StatEmployeeLastName,
                    person.StatEmployee!.StatEmployeeEmail,
                    person.PersonId,
                    person.Inactive != null && person.Inactive != IntegerBoolean.ZeroFalse));
    }

    public IAsyncEnumerable<int> GetFilteredEmployeeIds(EmployeeFilterCriteria filterCriteria)
    {
        Check.NotNull(filterCriteria, nameof(filterCriteria));

        return personRepository.GetFilteredEmployeePersons(
            filterCriteria,
            selector: person => person.StatEmployee!.StatEmployeeId);
    }

    private static Expression<Func<Person, PersonInfo>> PersonSelector()
    {
        return person => new PersonInfo(
            person.PersonId,
            person.PersonFirst,
            person.PersonLast,
            person.Gender!.GenderName,
            person.Race!.RaceName,
            // Formal rule:
            // 0 = false (active),
            // null = false (active),
            // any other value(inc. -1) = true (inactive)
            // I tried to make this into a value converter,
            // but this doesn't work correctly with filtering
            // queries, see https://github.com/dotnet/efcore/issues/24625.
            person.Inactive != null && person.Inactive != IntegerBoolean.ZeroFalse);
    }

}
