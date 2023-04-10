using System.Collections.Immutable;

namespace Statline.StatTrac.BusinessVeracity.Common.Domain;

public record ReferralDetails(
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
    string CallType)
{
    public ImmutableArray<ReferralLogEvent> LogEvents { get; init; } =
        ImmutableArray<ReferralLogEvent>.Empty;
}
