using Statline.StatTrac.Domain.Common;

namespace Statline.StatTrac.Domain.Referrals;

/// <dev>
/// This entity resembles corresponding DB table. 
/// </dev>
// TODO: Notes for future.
// Consider inheriting Referral
// from Call. They are always created
// together (but Call can also be created
// with other entities, which can also be
// considered inheritors).
// Also, in most cases to identify a referral
// call id is used (and EF uses base class's
// id as the id for derived class in TPT strategy).
// This would also be correct from repository design.
// Currently, when creating a referral, we need to actually
// create at least two aggregate root entities (Call and Referral)
// via corresponding repositories. From DDD perspective that's
// not correct: only single aggregate root should be created per
// transaction. Well, currently Call and Referral are created
// in separate implicit transactions via sprocs, which is not good
// as well.
public sealed class Referral
{
    // TODO: Make this internal after ensuring mapper works correctly.
    public Referral() { }

    public int ReferralId { get; set; }
    public int? CallId { get; set; }
    public int? ReferralCallerPhoneId { get; set; }
    public string? ReferralCallerExtension { get; set; }
    public int? ReferralCallerOrganizationId { get; set; }
    public int? ReferralCallerSubLocationId { get; set; }
    public string? ReferralCallerSubLocationLevel { get; set; }
    public int? ReferralCallerPersonId { get; set; }
    public string? ReferralDonorName { get; set; }
    public string? ReferralDonorRecNumber { get; set; }
    public int? ReferralDonorAge { get; set; }
    public string? ReferralDonorAgeUnit { get; set; }
    public int? ReferralDonorRaceId { get; set; }
    public string? ReferralDonorGender { get; set; }
    public float? ReferralDonorWeight { get; set; }
    public DateOnly? ReferralDonorAdmitDate { get; set; }
    public string? ReferralDonorAdmitTime { get; set; }
    public DateOnly? ReferralDonorDeathDate { get; set; }
    public string? ReferralDonorDeathTime { get; set; }
    public int? ReferralDonorCauseOfDeathId { get; set; }
    public string? ReferralDonorOnVentilator { get; set; }
    public string? ReferralDonorDead { get; set; }
    public ReferralType? ReferralTypeId { get; set; }
    public ApproachType? ReferralApproachTypeId { get; set; }
    public int? ReferralApproachedByPersonId { get; set; }
    public string? ReferralApproachNok { get; set; }
    public string? ReferralApproachRelation { get; set; }
    public AppropriateType? ReferralOrganAppropriateId { get; set; }
    public int? ReferralOrganApproachId { get; set; }
    public int? ReferralOrganConsentId { get; set; }
    public int? ReferralOrganConversionId { get; set; }
    public AppropriateType? ReferralBoneAppropriateId { get; set; }
    public int? ReferralBoneApproachId { get; set; }
    public int? ReferralBoneConsentId { get; set; }
    public int? ReferralBoneConversionId { get; set; }
    public AppropriateType? ReferralTissueAppropriateId { get; set; }
    public int? ReferralTissueApproachId { get; set; }
    public int? ReferralTissueConsentId { get; set; }
    public int? ReferralTissueConversionId { get; set; }
    public AppropriateType? ReferralSkinAppropriateId { get; set; }
    public int? ReferralSkinApproachId { get; set; }
    public int? ReferralSkinConsentId { get; set; }
    public int? ReferralSkinConversionId { get; set; }
    public AppropriateType? ReferralEyesTransAppropriateId { get; set; }
    public int? ReferralEyesTransApproachId { get; set; }
    public int? ReferralEyesTransConsentId { get; set; }
    public int? ReferralEyesTransConversionId { get; set; }
    public AppropriateType? ReferralEyesRschAppropriateId { get; set; }
    public int? ReferralEyesRschApproachId { get; set; }
    public int? ReferralEyesRschConsentId { get; set; }
    public int? ReferralEyesRschConversionId { get; set; }
    public AppropriateType? ReferralValvesAppropriateId { get; set; }
    public int? ReferralValvesApproachId { get; set; }
    public int? ReferralValvesConsentId { get; set; }
    public int? ReferralValvesConversionId { get; set; }
    public string? ReferralNotesCase { get; set; }
    public string? ReferralNotesPrevious { get; set; }
    public short? ReferralVerifiedOptions { get; set; }
    public short? ReferralCoronersCase { get; set; }
    public short? Inactive { get; set; }
    public int? ReferralCallerLevelId { get; set; }
    public DateTimeOffset? LastModified { get; set; }
    public short? UnusedField1 { get; set; }
    public string? ReferralDonorFirstName { get; set; }
    public string? ReferralDonorLastName { get; set; }
    public int? ReferralOrganDispositionId { get; set; }
    public int? ReferralBoneDispositionId { get; set; }
    public int? ReferralTissueDispositionId { get; set; }
    public int? ReferralSkinDispositionId { get; set; }
    public int? ReferralValvesDispositionId { get; set; }
    public int? ReferralEyesDispositionId { get; set; }
    public int? ReferralRschDispositionId { get; set; }
    public int? ReferralAllTissueDispositionId { get; set; }
    public int? ReferralPronouncingMd { get; set; }
    public int? UnusedField3 { get; set; }
    public string? ReferralNokPhone { get; set; }
    public int? ReferralAttendingMd { get; set; }
    public short? ReferralGeneralConsent { get; set; }
    public string? ReferralNokAddress { get; set; }
    public string? ReferralCoronerName { get; set; }
    public string? ReferralCoronerPhone { get; set; }
    public string? ReferralCoronerOrganization { get; set; }
    public string? ReferralCoronerNote { get; set; }
    public decimal? ReferralApproachTime { get; set; }
    public decimal? ReferralConsentTime { get; set; }
    public DateTimeOffset? Unused { get; set; }
    public short? ReferralDoa { get; set; }
    public DateOnly? ReferralDob { get; set; }
    public string? ReferralDonorSsn { get; set; }
    public short? UpdatedFlag { get; set; }
    public DateTimeOffset? ReferralExtubated { get; set; }
    public short? DonorRegistryType { get; set; }
    public int? DonorRegId { get; set; }
    public int? DonorDmvId { get; set; }
    public string? DonorDmvTable { get; set; }
    public short? DonorIntentDone { get; set; }
    public short? DonorFaxSent { get; set; }
    public short? DonorDsnId { get; set; }
    public int? ReferralDonorHeartBeat { get; set; }
    public int? ReferralCoronerOrgId { get; set; }
    public ReferralType? CurrentReferralTypeId { get; set; }
    public DateOnly? ReferralDonorBrainDeathDate { get; set; }
    public string? ReferralDonorBrainDeathTime { get; set; }
    public string? ReferralPronouncingMdphone { get; set; }
    public string? ReferralAttendingMdphone { get; set; }
    public short? ReferralDobIlb { get; set; }
    public string? ReferralDonorSpecificCod { get; set; }
    public string? ReferralDonorNameMi { get; set; }
    public int? ReferralNokId { get; set; }
    public short? ReferralQaReviewComplete { get; set; }
    public int? LastStatEmployeeId { get; set; }
    public AuditLogType? AuditLogTypeId { get; set; }
    public DateOnly? ReferralDonorLsaDate { get; set; }
    public string? ReferralDonorLsaTime { get; set; }
    public short? ReferralDcdPotential { get; set; }
    public short? ReferralPendingCase { get; set; }
    public short? ReferralPendingCaseCoordinator { get; set; }
    public string? ReferralPendingCaseComment { get; set; }
    public DateTimeOffset? ReferralPendingCaseLastModified { get; set; }
    public string? ReferralDonorRecNumberSearchable { get; set; }
    public DonorHighRiskValue? Hiv { get; set; }
    public int? Aids { get; set; }
    public DonorHighRiskValue? HepB { get; set; }
    public DonorHighRiskValue? HepC { get; set; }
    public int? Ivda { get; set; }
    public int? IdentityUnknown { get; set; }
    public int? AgeEstimated { get; set; }
    public int? WeightEstimated { get; set; }
    public string? PastMedicalHistory { get; set; }
    public string? AdmittingDiagnosis { get; set; }
    public bool? IsERferralCase { get; set; }

    public bool IsIncomplete => ReferralDonorGender is null;
}
