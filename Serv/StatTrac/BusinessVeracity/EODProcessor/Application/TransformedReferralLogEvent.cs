namespace Statline.StatTrac.BusinessVeracity.EodProcessor.Application;

public record TransformedReferralLogEvent
(   
    long? ContactId,
    int? ReferralEventTypeID,
    string ReferralEventType,
    string? ReferralEventDateTime,
    string ReferralEventPhone,
    int? ReferralEventOrganizationID,
    string ReferralEventOrganization,
    string ReferralEventCreatedBy
);
