using System.Collections.Immutable;

namespace Statline.StatTrac.BusinessVeracity.EodProcessor.Application;

public record TransformedReferralDetails(
    long ContactId,
    string ReferralNumber,
    string? ReferralDateTime,
    string ReferralTakenBy,
    string ReferralType,
    string CallerPhone,
    string CallerName,
    string CallerOrganization,
    string CallerOrganizationUnit,
    string PatientCauseOfDeath,
    string PatientOnVentilator,
    string? PatientDeathDate,
    string? PatientDeathTime,
    int? AppropriateOrganID,
    int? AppropriateBoneID,
    int? AppropriateSoftTissueID,
    int? AppropriateSkinID,
    int? AppropriateValvesID,
    int? AppropriateEyesID,
    string PatientHasHeartbeat,
    string MedicalHistory,
    string CallType,
    string SourceCode)
{
    public ImmutableArray<TransformedReferralLogEvent> ReferralEvents { get; init; } =
        ImmutableArray<TransformedReferralLogEvent>.Empty;
}
