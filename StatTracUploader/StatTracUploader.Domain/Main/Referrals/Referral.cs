﻿using System;

namespace Statline.StatTracUploader.Domain.Main.Referrals
{
    public class Referral
    {
        public int Id { get; set; }
        public int? CallId { get; set; }
        public int? CallerPhoneId { get; set; }
        public string? CallerExtension { get; set; }
        public int? CallerOrganizationId { get; set; }
        public int? CallerSubLocationId { get; set; }
        public string? CallerSubLocationLevel { get; set; }
        public int? CallerPersonId { get; set; }
        public string? DonorName { get; set; }
        public string? DonorRecNumber { get; set; }
        public int? DonorAge { get; set; }
        public string? DonorAgeUnit { get; set; }
        public int? DonorRaceId { get; set; }
        public string? DonorGender { get; set; }
        public float? DonorWeight { get; set; }
        /// <summary>
        /// This property has date/time in hospital's time zone.
        /// </summary>
        public DateTime? DonorAdmitDateTime { get; set; }
        /// <summary>
        /// This property has date/time in hospital's time zone.
        /// </summary>
        public DateTime? DonorDeathDateTime { get; set; }
        public int? DonorCauseOfDeathId { get; set; }
        public string? DonorOnVentilator { get; set; }
        public string? DonorDead { get; set; }
        public int? TypeId { get; set; }
        public int? ApproachTypeId { get; set; }
        public int? ApproachedByPersonId { get; set; }
        public string? ApproachNok { get; set; }
        public string? ApproachRelation { get; set; }
        public int? OrganAppropriateId { get; set; }
        public int? OrganApproachId { get; set; }
        public int? OrganConsentId { get; set; }
        public int? OrganConversionId { get; set; }
        public int? BoneAppropriateId { get; set; }
        public int? BoneApproachId { get; set; }
        public int? BoneConsentId { get; set; }
        public int? BoneConversionId { get; set; }
        public int? TissueAppropriateId { get; set; }
        public int? TissueApproachId { get; set; }
        public int? TissueConsentId { get; set; }
        public int? TissueConversionId { get; set; }
        public int? SkinAppropriateId { get; set; }
        public int? SkinApproachId { get; set; }
        public int? SkinConsentId { get; set; }
        public int? SkinConversionId { get; set; }
        public int? EyesTransAppropriateId { get; set; }
        public int? EyesTransApproachId { get; set; }
        public int? EyesTransConsentId { get; set; }
        public int? EyesTransConversionId { get; set; }
        public int? EyesRschAppropriateId { get; set; }
        public int? EyesRschApproachId { get; set; }
        public int? EyesRschConsentId { get; set; }
        public int? EyesRschConversionId { get; set; }
        public int? ValvesAppropriateId { get; set; }
        public int? ValvesApproachId { get; set; }
        public int? ValvesConsentId { get; set; }
        public int? ValvesConversionId { get; set; }
        public string? NotesCase { get; set; }
        public string? NotesPrevious { get; set; }
        public short? VerifiedOptions { get; set; }
        public short? CoronersCase { get; set; }
        public short? Inactive { get; set; }
        public int? CallerLevelId { get; set; }
        public DateTimeOffset? LastModified { get; set; }
        public short? UnusedField1 { get; set; }
        public string? DonorFirstName { get; set; }
        public string? DonorLastName { get; set; }
        public int? OrganDispositionId { get; set; }
        public int? BoneDispositionId { get; set; }
        public int? TissueDispositionId { get; set; }
        public int? SkinDispositionId { get; set; }
        public int? ValvesDispositionId { get; set; }
        public int? EyesDispositionId { get; set; }
        public int? RschDispositionId { get; set; }
        public int? AllTissueDispositionId { get; set; }
        public int? PronouncingMd { get; set; }
        public int? UnusedField3 { get; set; }
        public string? NokPhone { get; set; }
        public int? AttendingMd { get; set; }
        public short? GeneralConsent { get; set; }
        public string? NokAddress { get; set; }
        public string? CoronerName { get; set; }
        public string? CoronerPhone { get; set; }
        public string? CoronerOrganization { get; set; }
        public string? CoronerNote { get; set; }
        public decimal? ApproachTime { get; set; }
        public decimal? ConsentTime { get; set; }
        public DateTimeOffset? Unused { get; set; }
        public short? Doa { get; set; }
        public DateTimeOffset? Dob { get; set; }
        public string? DonorSsn { get; set; }
        public short? UpdatedFlag { get; set; }
        public DateTimeOffset? ExtubatedAt { get; set; }
        public short? DonorRegistryType { get; set; }
        public int? DonorRegId { get; set; }
        public int? DonorDmvId { get; set; }
        public string? DonorDmvTable { get; set; }
        public short? DonorIntentDone { get; set; }
        public short? DonorFaxSent { get; set; }
        public short? DonorDsnId { get; set; }
        public HeartbeatId? DonorHeartBeat { get; set; }
        public int? CoronerOrgId { get; set; }
        public int? CurrentTypeId { get; set; }
        public DateTime? DonorBrainDeathDateTime { get; set; }
        public string? PronouncingMdphone { get; set; }
        public string? AttendingMdphone { get; set; }
        public short? DobIlb { get; set; }
        public string? DonorSpecificCod { get; set; }
        public string? DonorNameMi { get; set; }
        public int? NokId { get; set; }
        public short? QaReviewComplete { get; set; }
        public int? LastStatEmployeeId { get; set; }
        public int? AuditLogTypeId { get; set; }
        public DateTime? DonorLsaDateTime { get; set; }
        public short? DcdPotential { get; set; }
        public short? PendingCase { get; set; }
        public short? PendingCaseCoordinator { get; set; }
        public string? PendingCaseComment { get; set; }
        public DateTimeOffset? PendingCaseLastModified { get; set; }
        public string? DonorRecNumberSearchable { get; set; }
        public int? Hiv { get; set; }
        public int? Aids { get; set; }
        public int? HepB { get; set; }
        public int? HepC { get; set; }
        public int? Ivda { get; set; }
        public int? IdentityUnknown { get; set; }
        public int? AgeEstimated { get; set; }
        public int? WeightEstimated { get; set; }
        public string? PastMedicalHistory { get; set; }
        public string? AdmittingDiagnosis { get; set; }
    }
}
