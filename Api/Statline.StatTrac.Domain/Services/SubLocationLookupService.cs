using Statline.StatTrac.Domain.Common;
using Statline.StatTrac.Domain.Organizations;
using Statline.StatTrac.Domain.Phones;
using Statline.StatTrac.Domain.SubLocations;
using System.Linq;

namespace Statline.StatTrac.Domain.Services;

public sealed class SubLocationLookupService
{
    private readonly ISubLocationRepository subLocationRepository;
    private readonly IPhoneRepository phoneRepository;

    public SubLocationLookupService(
        ISubLocationRepository subLocationRepository,
        IPhoneRepository phoneRepository)
    {
        this.phoneRepository = Check.NotNull(phoneRepository);
        this.subLocationRepository = Check.NotNull(subLocationRepository);
    }

    public async Task<SubLocationInfo?> FindSubLocationByOrganizationPhoneAsync(
        OrganizationId organizationId,
        PhoneNumber? phoneNumber)
    {
        return await GetFilteredSubLocations(
            organizationId,
            new SubLocationFilterCriteria { PhoneNumber = phoneNumber })
            .FirstOrDefaultAsync();
    }

    public IAsyncEnumerable<SubLocationInfo> GetFilteredSubLocations(
        OrganizationId organizationId,
        SubLocationFilterCriteria filterCriteria)
    {
        Check.NotNull(filterCriteria).Validate(nameof(filterCriteria));

        var phoneNumber = filterCriteria.PhoneNumber;

        // Though currently filter criteria includes only phone,
        // and a phone can have only single sub-location associated
        // with it, this method is written to do generalized search
        // and supports adding other criteria in future. These new
        // future criteria may yield many sub-locations.
        var subLocations = phoneRepository.QueryOrganizationPhones(
             orgPhone =>
                (phoneNumber == null || // To suppress warnings
                orgPhone.PhoneAreaCode == phoneNumber.AreaCode &&
                orgPhone.PhonePrefix == phoneNumber.Prefix &&
                orgPhone.PhoneNumber == phoneNumber.Number) &&
                orgPhone.OrganizationId == organizationId.Value &&
                orgPhone.SubLocationId != null,
            orgPhone => 
                new 
                { 
                    Id = orgPhone.SubLocationId!.Value,
                    Level  = (string?)orgPhone.SubLocationLevel // Cast is to remove warning. 
                });

        // This might be not the most efficient way to 
        // "join" the results. Another approach could be using
        // Contains operation, so that it could require single query.
        // However, this would require materialization of whole sub-location
        // results collection. Since other search criteria can be added later,
        // such approach may start consuming way more memory. I think it's better
        // to review this design when it start causing real problems.
        //
        // Also note, that it's INTENTIONAL that OrganizationPhone and
        // SubLocation don't reference each other (which would allow real join at DB level).
        // These two entities look to be separate aggregate roots (in DDD terms) and thus
        // should be independent. If join are required for performance, then CQRS pattern should
        // be used (a separate read model which is allowed to be arbitrary shape for representation
        // and performance requirements).

        return 
            from subLocation in subLocations
            from subLocationInfo in subLocationRepository.QuerySubLocations(
                sl => sl.SubLocationId == subLocation.Id,
                sl => new SubLocationInfo(
                    sl.SubLocationId,
                    sl.SubLocationName,
                    subLocation.Level))
            select subLocationInfo;
    }
}
