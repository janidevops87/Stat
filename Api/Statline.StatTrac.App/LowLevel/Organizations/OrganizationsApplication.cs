using Statline.StatTrac.Domain.Common;
using Statline.StatTrac.Domain.Organizations;
using Statline.StatTrac.Domain.Phones;
using Statline.StatTrac.Domain.Services;
using Statline.StatTrac.Domain.SubLocations;
using System.Linq;

namespace Statline.StatTrac.App.LowLevel.Organizations;

public class OrganizationsApplication
{
    private readonly IOrganizationRepository organizationRepository;
    private readonly IPhoneRepository phoneRepository;
    private readonly ISubLocationRepository subLocationRepository;

    public OrganizationsApplication(
        IOrganizationRepository organizationRepository,
        IPhoneRepository phoneRepository,
        ISubLocationRepository subLocationRepository)
    {
        this.organizationRepository = Check.NotNull(organizationRepository);
        this.phoneRepository = Check.NotNull(phoneRepository);
        this.subLocationRepository = Check.NotNull(subLocationRepository);
    }

    public IAsyncEnumerable<OrganizationInfo> GetFilteredOrganizations(
        OrganizationFilterCriteria filterCriteria)
    {
        return organizationRepository.GetFilteredOrganizations(filterCriteria);
    }

    public IAsyncEnumerable<int> GetFilteredOrganizationIds(
        OrganizationFilterCriteria filterCriteria)
    {
        return organizationRepository.GetFilteredOrganizationIds(filterCriteria);
    }

    public IAsyncEnumerable<SubLocationInfo> GetFilteredSubLocations(
       OrganizationId organizationId,
       SubLocationFilterCriteria filterCriteria)
    {
        var subLocationLookupService = new SubLocationLookupService(subLocationRepository, phoneRepository);

        return subLocationLookupService.GetFilteredSubLocations(
           organizationId, filterCriteria);
    }

    public IAsyncEnumerable<PhoneInfo> GetFilteredPhones(
       OrganizationId organizationId,
       PhoneFilterCriteria filterCriteria)
    {
        return phoneRepository.GetFilteredOrganizationPhones(
            organizationId, 
            filterCriteria,
            orgPhone => new PhoneInfo(
                orgPhone.PhoneId,
                new PhoneNumber(
                    orgPhone.PhoneAreaCode!,
                    orgPhone.PhonePrefix!,
                    orgPhone.PhoneNumber!)));
    }

    public IAsyncEnumerable<int> GetFilteredOrganizationPhoneIds(
        OrganizationId organizationId,
        PhoneFilterCriteria filterCriteria)
    {
        return phoneRepository.GetFilteredOrganizationPhoneIds(
            organizationId,
            filterCriteria)
            .Select(id => id.Value);
    }
}
