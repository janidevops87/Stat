using Statline.StatTrac.Domain.Organizations;

namespace Statline.StatTrac.Domain.Referrals.Factory;

public class RawOrganizationInfo
{
    public OrganizationId Id { get; }
    public string? TimeZoneAbbreviation { get; }
    public string IanaTimeZoneId { get; }

    public RawOrganizationInfo(
        OrganizationId id, 
        string? timeZoneAbbreviation, 
        string ianaTimeZoneId)
    {
        Id = id;
        TimeZoneAbbreviation = timeZoneAbbreviation;
        IanaTimeZoneId = Check.NotEmpty(ianaTimeZoneId);
    }
}
