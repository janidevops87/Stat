namespace Statline.StatTrac.BusinessVeracity.Common.Domain;

public record ReferralLogEvent
(
    int LogEventId,
    int ReferralId,
    ReferralLogEventType? LogEventTypeId,
    string LogEventTypeName,
    DateTimeOffset? LogEventDateTime,
    string LogEventPhone,
    int? OrganizationId,
    string LogEventOrg,
    string LogEventCreatedBy);
