using Statline.StatTrac.Domain.Common;
using Statline.StatTrac.Domain.Organizations;
using Statline.StatTrac.Domain.Persons;
using Statline.StatTrac.Domain.Persons.Factory;

namespace Statline.StatTrac.App.HighLevel.Persons;

public class PersonsHighLevelApplication
{
    private readonly IPersonRepository personRepository;
    private readonly PersonFactory personFactory;
    private readonly IOrganizationRepository organizationRepository;

    public PersonsHighLevelApplication(
        IPersonRepository personRepository,
        IOrganizationRepository organizationRepository,
        PersonFactory personFactory)
    {
        this.personRepository = Check.NotNull(personRepository);
        this.organizationRepository = Check.NotNull(organizationRepository);
        this.personFactory = Check.NotNull(personFactory);
    }

    public async Task<int> AddPersonAsync(
        int organizationId, 
        PersonInfo newPersonInfo, 
        int onBehalfOfEmployeeId)
    {
        Check.NotNull(newPersonInfo);

        Person person = await personFactory.CreateFromPersonInfoAsync(
            organizationId,
            newPersonInfo,
            onBehalfOfEmployeeId);

        await personRepository.AddPersonAsync(person);

        return person.PersonId;
    }

    public IAsyncEnumerable<PersonId> GetIdsOfFilteredPersons(PersonFilterCriteria filterCriteria)
    {
        Check.NotNull(filterCriteria, nameof(filterCriteria));

        return personRepository.GetFilteredPersons(
            filterCriteria,
            selector: person => person.PersonId);
    }

    public IAsyncEnumerable<PersonId> GetIdsOfFilteredPersonsOrdered(
        PersonFilterCriteria filterCriteria)
    {
        Check.NotNull(filterCriteria, nameof(filterCriteria));

        return personRepository.GetFilteredPersonsOrdered(
            filterCriteria,
            selector: person => person.PersonId,
            // NOTE: Here we simplify life to ourselves
            // and assume Inactive can only be 0 or 1,
            // relying on filtering predicate.
            (p => p.Inactive, Ordering.Ascending),
            (p => p.PersonFirst, Ordering.Ascending),
            (p => p.PersonLast, Ordering.Ascending));
    }
}
