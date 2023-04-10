#nullable disable

namespace Statline.StatTrac.Domain.EReferrals;

public class FacilityInfo
{
    public int? OrganizationId { get; set; }
    public string FacilityCode { get; set; }
    public string FacilityName { get; set; }
    public string ContactFirstName { get; set; }
    public string ContactLastName { get; set; }
    public int? ContactTitleId { get; set; }
    public int? TimeZoneId { get; set; }
    public string TimeZoneAbbr { get; set; }
    public int? ObservesDaylightSavings { get; set; }
}
