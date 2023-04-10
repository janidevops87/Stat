using Statline.StatTrac.Domain.Phones;

namespace Statline.StatTrac.Domain.Organizations;

public class Organization
{
    internal Organization() { }

    public int OrganizationId { get; private set; }
    public string? OrganizationName { get; private set; }
    public string? OrganizationAddress1 { get; private set; }
    public string? OrganizationAddress2 { get; private set; }
    public string? OrganizationCity { get; private set; }
    public int? StateId { get; private set; }
    public string? OrganizationZipCode { get; private set; }
    public int? CountyId { get; private set; }
    public int? OrganizationTypeId { get; private set; }
    public int? PhoneId { get; private set; }
    public string? OrganizationTimeZone { get; private set; }
    public string? OrganizationNotes { get; private set; }
    public short? OrganizationNoPatientName { get; private set; }
    public short? OrganizationNoRecordNum { get; private set; }
    public short? Verified { get; private set; }
    public short? Inactive { get; private set; }
    public short? OrganizationNoAdmitDateTime { get; private set; }
    public short? OrganizationNoWeight { get; private set; }
    public short? OrganizationConfCallCust { get; private set; }
    public short? Unused2 { get; private set; }
    public short? Unused3 { get; private set; }
    public short? Unused4 { get; private set; }
    public short? Unused5 { get; private set; }
    public short? Unused6 { get; private set; }
    public int? OrganizationPageInterval { get; private set; }
    public DateTimeOffset? LastModified { get; private set; }
    public short? Unused8 { get; private set; }
    public string? OrganizationUserCode { get; private set; }
    public string? OrganizationReferralNotes { get; private set; }
    public string? OrganizationMessageNotes { get; private set; }
    public int? OrganizationConsentInterval { get; private set; }
    public short OrganizationLo { get; private set; }
    public short OrganizationLoenabled { get; private set; }
    public int? OrganizationLotype { get; private set; }
    public short? OrganizationLotriageEnabled { get; private set; }
    public short? OrganizationLofsenabled { get; private set; }
    public short? OrganizationArchive { get; private set; }
    public int? LastStatEmployeeId { get; private set; }
    public int? AuditLogTypeId { get; private set; }
    public bool? ContractedStatlineClient { get; private set; }
    public int? CountryId { get; private set; }
    public string? ProviderNumber { get; private set; }
    public string? UnosCode { get; private set; }
    public int? OrganizationStatusId { get; private set; }
    public int? TimeZoneId { get; private set; }
    public bool? ObservesDaylightSavings { get; private set; }
    public int? IddId { get; private set; }
    public int? CountryCodeId { get; private set; }
    public bool? StatTracOrganization { get; private set; }
    public string? FacilityEreferralCode { get; private set; }
    public ICollection<OrganizationPhone> OrganizationPhones { get; private set; } = default!;
}
