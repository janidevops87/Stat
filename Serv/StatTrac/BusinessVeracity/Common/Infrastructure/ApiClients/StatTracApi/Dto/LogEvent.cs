namespace Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ApiClients.StatTracApi.Dto;

public sealed class LogEvent
{
    public string CallNumber { get; set; } = default!;
    public DateTimeOffset? LastModified { get; set; }
    public string LogEventCreatedBy { get; set; } = default!;
    public DateTimeOffset? LogEventDateTime { get; set; }
    public string LogEventDesc { get; set; } = default!;
    public int LogEventId { get; set; }
    public string LogEventName { get; set; } = default!;
    public string LogEventOrg { get; set; } = default!;
    public string LogEventPhone { get; set; } = default!;
    public int? LogEventTypeId { get; set; }
    public string LogEventTypeName { get; set; } = default!;
    public int? OrganizationId { get; set; }
    public int? PersonId { get; set; }
    public string ReferralEventAttnTo { get; set; } = default!;
    public string ReferralEventCalloutAfter { get; set; } = default!;
    public int? ReferralEventCalloutMin { get; set; }
    public short? ReferralEventContactConfirm { get; set; }
    public string ReferralEventDocName { get; set; } = default!;
    public string ReferralEventFaxNbr { get; set; } = default!;
    public int ReferralId { get; set; }
}
