namespace Statline.StatTracUploader.Infrastructure.Services.StatTracApi.Model.Referrals
{
    internal class DuplicateReferralsFilterCriteria
    {
        public DuplicateReferralsFilterType FilterType { get; set; }
        public string? ReferralDonorLastName { get; set; }
        public int? SourceCodeId { get; set; }
        public string? TimeZone { get; set; }
        public string? MedicalRecordNumber { get; set; }
        public int? CallCoordinatorOrganizationId { get; set; }
        public int? ReferralCallerOrganizationId { get; set; }
    }
}
