namespace Statline.StatTracUploader.Domain.Main.Referrals
{
    public class DuplicateReferralsFilterCriteria
    {
        public DuplicateReferralsFilterCriteria(
            int? sourceCodeId,
            string? medicalRecordNumber,
            int? referralCallerOrganizationId)
        {
            SourceCodeId = sourceCodeId;
            MedicalRecordNumber = medicalRecordNumber;
            ReferralCallerOrganizationId = referralCallerOrganizationId;
        }

        public int? SourceCodeId { get; }
        public string? MedicalRecordNumber { get; }
        public int? ReferralCallerOrganizationId { get; }
    }
}
