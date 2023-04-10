using Statline.StatTrac.BusinessVeracity.Common.Domain;

namespace Statline.StatTrac.BusinessVeracity.QAProcessor.Domain;

public record HighRiskReferralDetails : ReferralDetails
{
    public int HighRiskLogEventId { get; init; }
    public string HighRiskType { get; init; }

    public HighRiskReferralDetails(
        int CallId,
        int ReferralId,
        DateTimeOffset? CallDateTime,
        string Caller,
        string CallerOrganizationUnit,
        string CallerPhone,
        string CallNumber,
        string CauseOfDeathName,
        string MedicalHistory,
        string OrganizationName,
        string PatientHasHeartbeat,
        int? ReferralBoneAppropriateId,
        DateTime? ReferralDonorDeathDate,
        string? ReferralDonorDeathTime,
        string ReferralDonorOnVentilator,
        int? ReferralEyesTransAppropriateId,
        int? ReferralOrganAppropriateId,
        int? ReferralSkinAppropriateId,
        int? ReferralTissueAppropriateId,
        string ReferralTypeName,
        int? ReferralValvesAppropriateId,
        string StatEmployee,
        string SourceCode,
        string CallType,
        int HighRiskLogEventId,
        string HighRiskType) : base(
            CallId,
            ReferralId,
            CallDateTime,
            Caller,
            CallerOrganizationUnit,
            CallerPhone,
            CallNumber,
            CauseOfDeathName,
            MedicalHistory,
            OrganizationName,
            PatientHasHeartbeat,
            ReferralBoneAppropriateId,
            ReferralDonorDeathDate,
            ReferralDonorDeathTime,
            ReferralDonorOnVentilator,
            ReferralEyesTransAppropriateId,
            ReferralOrganAppropriateId,
            ReferralSkinAppropriateId,
            ReferralTissueAppropriateId,
            ReferralTypeName,
            ReferralValvesAppropriateId,
            StatEmployee,
            SourceCode,
            CallType)
    {
        this.HighRiskLogEventId = HighRiskLogEventId;
        this.HighRiskType = HighRiskType;
    }
}
