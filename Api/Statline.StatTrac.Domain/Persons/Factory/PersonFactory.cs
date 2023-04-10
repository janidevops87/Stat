using Statline.StatTrac.Domain.Common;
using Statline.StatTrac.Domain.Organizations;

namespace Statline.StatTrac.Domain.Persons.Factory;

public class PersonFactory
{
    private readonly IPersonRepository personRepository;
    private readonly IOrganizationRepository organizationRepository;

    public PersonFactory(
        IPersonRepository personRepository,
        IOrganizationRepository organizationRepository)
    {
        this.personRepository = Check.NotNull(personRepository);
        this.organizationRepository = Check.NotNull(organizationRepository);
    }

    public Person CreateWithDefaultValues()
    {
        // Some of properties of call are expected to have
        // default non-null values when values are not provided.
        // So unless client later explicitly assigns such property
        // with null it will have default value.
        return new Person
        {
            #pragma warning disable format
            Inactive        = IntegerBoolean.ZeroFalse,
            AuditLogTypeId  = AuditLogType.Create
            #pragma warning restore format
        };
    }

    public async Task<Person> CreateFromPersonInfoAsync(
        OrganizationId organizationId, 
        PersonInfo newPersonInfo, 
        int onBehalfOfEmployeeId)
    {
        Check.NotNull(newPersonInfo);

        await personRepository.ValidateEmployeeIdAsync(onBehalfOfEmployeeId);

        await organizationRepository.CheckOrganizationWithIdExistsAsync(organizationId);

        return CreateFromRawPersonInfo(
            organizationId,
            newPersonInfo,
            onBehalfOfEmployeeId);
    }

    public Person CreateFromRawPersonInfo(
        OrganizationId organizationId,
        PersonInfo newPersonInfo,
        int onBehalfOfEmployeeId)
    {
        var person = CreateWithDefaultValues();

        #pragma warning disable format
        person.PersonFirst        = newPersonInfo.Name.FirstName;
        person.PersonLast         = newPersonInfo.Name.LastName;
        person.OrganizationId     = organizationId;
        person.LastStatEmployeeId = onBehalfOfEmployeeId;
        #pragma warning restore format

        return person;
    }
}
