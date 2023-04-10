using Statline.StatTrac.Domain.Common;

namespace Statline.StatTrac.Domain.LogEvents;

public class LogEvent
{
    public int LogEventId { get; set; }
    public int? CallId { get; set; }
    public LogEventTypeId? LogEventTypeId { get; set; }
    public DateTimeOffset? LogEventDateTime { get; set; }
    public int? LogEventNumber { get; set; }
    public string? LogEventName { get; set; }
    public string? LogEventPhone { get; set; }
    public string? LogEventOrg { get; set; }
    public string? LogEventDesc { get; set; }
    public int? StatEmployeeId { get; set; }
    public IntegerBoolean? LogEventCallbackPending { get; set; }
    public DateTimeOffset? LastModified { get; set; }
    public int? ScheduleGroupId { get; set; }
    public int? PersonId { get; set; }
    public int? OrganizationId { get; set; }
    public int? PhoneId { get; set; }
    public short? LogEventContactConfirmed { get; set; }
    public short? UpdatedFlag { get; set; }
    public DateTimeOffset? LogEventCalloutDateTime { get; set; }
    public int? LastStatEmployeeId { get; set; }
    public int? AuditLogTypeId { get; set; }
    public bool? LogEventDeleted { get; set; }

    public LogEventType? LogEventType { get; set; }
}
