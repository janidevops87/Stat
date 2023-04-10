namespace Statline.StatTrac.Domain.Referrals;

public class DuplicateReferralsFilterCriteria
{
    public DuplicateReferralsFilterCriteria(
        DuplicateReferralsFilterType filterType,
        string? referralDonorLastName = default,
        int? sourceCodeId = default,
        string? timeZone = default,
        string? medicalRecordNumber = default,
        int? callCoordinatorOrganizationId = default,
        int? referralCallerOrganizationId = default)
    {
        FilterType = filterType;
        ReferralDonorLastName = referralDonorLastName;
        SourceCodeId = sourceCodeId;
        TimeZone = timeZone;
        MedicalRecordNumber = medicalRecordNumber;
        CallCoordinatorOrganizationId = callCoordinatorOrganizationId;
        ReferralCallerOrganizationId = referralCallerOrganizationId;
    }

    public DuplicateReferralsFilterType FilterType { get; }
    public string? ReferralDonorLastName { get; }
    public int? SourceCodeId { get; }
    public string? TimeZone { get; }
    public string? MedicalRecordNumber { get; }
    public int? CallCoordinatorOrganizationId { get; }
    public int? ReferralCallerOrganizationId { get; }
}