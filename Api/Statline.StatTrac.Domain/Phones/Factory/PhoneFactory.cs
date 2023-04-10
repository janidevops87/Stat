using Statline.StatTrac.Domain.Common;
using Statline.StatTrac.Domain.Organizations;
using Statline.StatTrac.Domain.Persons;
using Statline.StatTrac.Domain.SubLocations;

namespace Statline.StatTrac.Domain.Phones.Factory;

public class PhoneFactory
{
    private readonly IOrganizationRepository organizationRepository;
    private readonly IPersonRepository personRepository;
    private readonly ISubLocationRepository subLocationRepository;

    public PhoneFactory(
        IPersonRepository personRepository,
        IOrganizationRepository organizationRepository,
        ISubLocationRepository subLocationRepository)
    {
        this.organizationRepository = Check.NotNull(organizationRepository);
        this.personRepository = Check.NotNull(personRepository);
        this.subLocationRepository = Check.NotNull(subLocationRepository);
    }

    public OrganizationPhone CreateOrganizationPhoneWithDefaultValues()
    {
        // Some of properties of call are expected to have
        // default non-null values when values are not provided.
        // So unless client later explicitly assigns such property
        // with null it will have default value.
        return new OrganizationPhone
        {
            #pragma warning disable format
            Inactive                        = IntegerBoolean.ZeroFalse,
            OrganizationPhoneInactive       = IntegerBoolean.ZeroFalse,
            AuditLogTypeId                  = AuditLogType.Create,
            OrganizationPhoneAuditLogTypeId = AuditLogType.Create
            #pragma warning restore format
        };
    }

    public async Task<OrganizationPhone> CreateOrganizationPhoneFromPhoneInfoAsync(
        OrganizationId organizationId,
        PhoneInfo newPhoneInfo,
        int onBehalfOfEmployeeId)
    {
        Check.NotNull(newPhoneInfo);

        await personRepository.ValidateEmployeeIdAsync(onBehalfOfEmployeeId);

        await organizationRepository.CheckOrganizationWithIdExistsAsync(organizationId);

        RawPhoneInfo rawNewPhoneInfo = await BuildRawPhoneInfoAsync(newPhoneInfo);

        return CreateOrganizationPhoneFromRawPhoneInfo(
            organizationId,
            rawNewPhoneInfo,
            onBehalfOfEmployeeId);
    }

    
    public OrganizationPhone CreateOrganizationPhoneFromRawPhoneInfo(
        OrganizationId organizationId,
        RawPhoneInfo newPhoneInfo,
        int onBehalfOfEmployeeId)
    {
        var phone = CreateOrganizationPhoneWithDefaultValues();
        
        var phoneNumber = newPhoneInfo.PhoneNumber;

        #pragma warning disable format
        phone.OrganizationId                        = organizationId;
        phone.PhoneAreaCode                         = phoneNumber.AreaCode;
        phone.PhonePrefix                           = phoneNumber.Prefix;
        phone.PhoneNumber                           = phoneNumber.Number;
        phone.PhoneTypeId                           = newPhoneInfo.PhoneType;
        phone.SubLocationId                         = newPhoneInfo.Location?.Id;
        phone.SubLocationLevel                      = newPhoneInfo.Location?.Level;
        phone.AuditLogTypeId                        = AuditLogType.Create;
        phone.LastStatEmployeeId                    = onBehalfOfEmployeeId;
        phone.OrganizationPhoneLastStatEmployeeId   = onBehalfOfEmployeeId;
        #pragma warning restore format

        return phone;
    }
    private async Task<RawPhoneInfo> BuildRawPhoneInfoAsync(PhoneInfo newPhoneInfo)
    {
        int? subLocationId = null;

        var location = newPhoneInfo.Location;

        if (location?.Name is not null)
        {
            subLocationId = (await subLocationRepository.FindSubLocationByNameAsync(
                location.Name))?.SubLocationId;
        }

        var rawNewPhoneInfo = new RawPhoneInfo(
            newPhoneInfo.PhoneNumber,
            newPhoneInfo.Type,
            new RawHospitalSubLocationInfo(subLocationId, location?.Level));

        return rawNewPhoneInfo;
    }
}
