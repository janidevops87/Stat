using Statline.StatTrac.Domain.Organizations;

namespace Statline.StatTrac.Domain.TimeZones;

public sealed class TimeZoneLookupService
{
    private readonly ITimeZoneRepository timeZoneRepository;
    private readonly IOrganizationRepository organizationRepository;

    public TimeZoneLookupService(
        ITimeZoneRepository timeZoneRepository,
        IOrganizationRepository organizationRepository)
    {
        this.timeZoneRepository = Check.NotNull(timeZoneRepository);
        this.organizationRepository = Check.NotNull(organizationRepository);
    }

    public async Task<TimeZone> GetOrganizationTimeZoneAsync(OrganizationId organizationId)
    {
        var organizationWithTimeZoneInfo = await organizationRepository.FindOrganizationByIdAsync(
            organizationId,
            org => new { org.TimeZoneId });

        if (organizationWithTimeZoneInfo is null)
        {
            throw new ArgumentException(
                $"Can't find organization with id '{organizationId}'.",
                nameof(organizationId));
        }

        if (organizationWithTimeZoneInfo.TimeZoneId is null)
        {
            throw new InvalidOperationException(
               $"Organization with id '{organizationId}' " +
               $"has no time zone associated with it.");
        }

        var timeZoneInfo = await timeZoneRepository.FindTimeZoneAsync(
            organizationWithTimeZoneInfo.TimeZoneId.Value);

        if (timeZoneInfo is null)
        {
            // This is an internal error due to invalid
            // reference of time zone in the organization.
            throw new InvalidOperationException(
                $"Organization with id '{organizationId}' " +
                $"references non-existing time zone " +
                $"with id '{organizationWithTimeZoneInfo.TimeZoneId}'.");
        }

        return timeZoneInfo;
    }
}
