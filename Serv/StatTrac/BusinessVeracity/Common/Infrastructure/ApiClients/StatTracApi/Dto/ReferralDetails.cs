using System.Collections.Immutable;

namespace Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ApiClients.StatTracApi.Dto;

public sealed class ReferralDetails
{
    public string ApproachBy { get; set; } = default!;
    public string ApproachTypeName { get; set; } = default!;
    public string AttendingPhysician { get; set; } = default!;
    public DateTimeOffset? CallDateTime { get; set; }
    public string Caller { get; set; } = default!;
    public string CallerOrganizationUnit { get; set; } = default!;
    public string CallerPhone { get; set; } = default!;
    public string CallNumber { get; set; } = default!;
    public string CauseOfDeathName { get; set; } = default!;
    public string CoronerName { get; set; } = default!;
    public string CoronerNote { get; set; } = default!;
    public string CoronerOrganization { get; set; } = default!;
    public string CoronerPhone { get; set; } = default!;
    public string CoronerState { get; set; } = default!;
    public string CoronorsCase { get; set; } = default!;
    public string CountyName { get; set; } = default!;
    public int? CurrentReferralTypeId { get; set; }
    public string CustomField_1 { get; set; } = default!;
    public string CustomField_10 { get; set; } = default!;
    public string CustomField_11 { get; set; } = default!;
    public string CustomField_12 { get; set; } = default!;
    public string CustomField_13 { get; set; } = default!;
    public string CustomField_14 { get; set; } = default!;
    public string CustomField_15 { get; set; } = default!;
    public string CustomField_16 { get; set; } = default!;
    public string CustomField_2 { get; set; } = default!;
    public string CustomField_3 { get; set; } = default!;
    public string CustomField_4 { get; set; } = default!;
    public string CustomField_5 { get; set; } = default!;
    public string CustomField_6 { get; set; } = default!;
    public string CustomField_7 { get; set; } = default!;
    public string CustomField_8 { get; set; } = default!;
    public string CustomField_9 { get; set; } = default!;
    public string DOA { get; set; } = default!;
    public DateTimeOffset? CallLastModified { get; set; }
    public string MedicalHistory { get; set; } = default!;
    public string NOKCity { get; set; } = default!;
    public string NOKFirstName { get; set; } = default!;
    public string NOKLastName { get; set; } = default!;
    public string NOKPhone { get; set; } = default!;
    public string NOKState { get; set; } = default!;
    public string NOKZip { get; set; } = default!;
    public string NOKAddress { get; set; } = default!;
    public string OrganizationName { get; set; } = default!;
    public string OrganizationUserCode { get; set; } = default!;
    public string PatientHasHeartbeat { get; set; } = default!;
    public string PatientWeight_Decimal { get; set; } = default!;
    public string PersonTypeName { get; set; } = default!;
    public string PronouncingPhysician { get; set; } = default!;
    public string RaceName { get; set; } = default!;
    public ImmutableArray<LogEvent> ReferralLogEvents { get; set; } = ImmutableArray<LogEvent>.Empty;
    public int? ReferralAllTissueDispositionId { get; set; }
    public string ReferralApproachNOK { get; set; } = default!;
    public string ReferralApproachRelation { get; set; } = default!;
    public int? ReferralApproachTypeId { get; set; }
    public string ReferralAttendingMDPhone { get; set; } = default!;
    public int? ReferralBoneApproachId { get; set; }
    public int? ReferralBoneAppropriateId { get; set; }
    public int? ReferralBoneConsentId { get; set; }
    public int? ReferralBoneConversionId { get; set; }
    public int? ReferralBoneDispositionId { get; set; }
    public string ReferralCallerExtension { get; set; } = default!;
    public int ReferralCoronersCase { get; set; }
    public string ReferralDOB { get; set; } = default!;
    public int ReferralDonor_ILB { get; set; }
    public DateTime? ReferralDonorAdmitDate { get; set; }
    public string ReferralDonorAdmitTime { get; set; } = default!;
    public string ReferralDonorAge { get; set; } = default!;
    public string ReferralDonorAgeUnit { get; set; } = default!;
    public DateTime? ReferralDonorBrainDeathDate { get; set; }
    public string ReferralDonorBrainDeathTime { get; set; } = default!;
    public int? ReferralDonorCauseOfDeathId { get; set; }
    public DateTime? ReferralDonorDeathDate { get; set; }
    public string ReferralDonorDeathTime { get; set; } = default!;
    public string ReferralDonorFirstName { get; set; } = default!;
    public string ReferralDonorGender { get; set; } = default!;
    public string ReferralDonorLastName { get; set; } = default!;
    public DateTime? ReferralDonorLSADate { get; set; }
    public string ReferralDonorLSATime { get; set; } = default!;
    public string ReferralDonorNameMI { get; set; } = default!;
    public string ReferralDonorOnVentilator { get; set; } = default!;
    public int? ReferralDonorRaceId { get; set; }
    public string ReferralDonorRecNumber { get; set; } = default!;
    public string ReferralDonorSpecificCOD { get; set; } = default!;
    public string ReferralDonorSSN { get; set; } = default!;
    public string ReferralDonorWeight { get; set; } = default!;
    public string ReferralExtubated { get; set; } = default!;
    public int? ReferralEyesDispositionId { get; set; }
    public int? ReferralEyesRschApproachId { get; set; }
    public int? ReferralEyesRschAppropriateId { get; set; }
    public int? ReferralEyesRschConsentId { get; set; }
    public int? ReferralEyesRschConversionId { get; set; }
    public int? ReferralEyesTransApproachId { get; set; }
    public int? ReferralEyesTransAppropriateId { get; set; }
    public int? ReferralEyesTransConsentId { get; set; }
    public int? ReferralEyesTransConversionId { get; set; }
    public short? ReferralGeneralConsent { get; set; }
    public int ReferralId { get; set; }
    public int CallId { get; set; }
    public DateTimeOffset? ReferralLastModified { get; set; }
    public int? ReferralOrganApproachId { get; set; }
    public int? ReferralOrganAppropriateId { get; set; }
    public int? ReferralOrganConsentId { get; set; }
    public int? ReferralOrganConversionId { get; set; }
    public int? ReferralOrganDispositionId { get; set; }
    public string ReferralPronouncingMDPhone { get; set; } = default!;
    public int? ReferralRschDispositionId { get; set; }
    public int? ReferralSkinApproachId { get; set; }
    public int? ReferralSkinAppropriateId { get; set; }
    public int? ReferralSkinConsentId { get; set; }
    public int? ReferralSkinConversionId { get; set; }
    public int? ReferralSkinDispositionId { get; set; }
    public string ReferralStatus { get; set; } = default!;
    public int ReferralStatusId { get; set; }
    public int? ReferralTissueApproachId { get; set; }
    public int? ReferralTissueAppropriateId { get; set; }
    public int? ReferralTissueConsentId { get; set; }
    public int? ReferralTissueConversionId { get; set; }
    public int? ReferralTissueDispositionId { get; set; }
    public int? ReferralTypeId { get; set; }
    public string ReferralTypeName { get; set; } = default!;
    public int? ReferralValvesApproachId { get; set; }
    public int? ReferralValvesAppropriateId { get; set; }
    public int? ReferralValvesConsentId { get; set; }
    public int? ReferralValvesConversionId { get; set; }
    public int? ReferralValvesDispositionId { get; set; }
    public int? RegistryStatusId { get; set; }
    public string RegistryStatusType { get; set; } = default!;
    public string ServiceLevelCustomFieldLabel_1 { get; set; } = default!;
    public string ServiceLevelCustomFieldLabel_10 { get; set; } = default!;
    public string ServiceLevelCustomFieldLabel_11 { get; set; } = default!;
    public string ServiceLevelCustomFieldLabel_12 { get; set; } = default!;
    public string ServiceLevelCustomFieldLabel_13 { get; set; } = default!;
    public string ServiceLevelCustomFieldLabel_14 { get; set; } = default!;
    public string ServiceLevelCustomFieldLabel_15 { get; set; } = default!;
    public string ServiceLevelCustomFieldLabel_16 { get; set; } = default!;
    public string ServiceLevelCustomFieldLabel_2 { get; set; } = default!;
    public string ServiceLevelCustomFieldLabel_3 { get; set; } = default!;
    public string ServiceLevelCustomFieldLabel_4 { get; set; } = default!;
    public string ServiceLevelCustomFieldLabel_5 { get; set; } = default!;
    public string ServiceLevelCustomFieldLabel_6 { get; set; } = default!;
    public string ServiceLevelCustomFieldLabel_7 { get; set; } = default!;
    public string ServiceLevelCustomFieldLabel_8 { get; set; } = default!;
    public string ServiceLevelCustomFieldLabel_9 { get; set; } = default!;
    public string StatEmployee { get; set; } = default!;
    public string SourceCode { get; set; } = default!;
    public string CallType { get; set; } = default!;
}
