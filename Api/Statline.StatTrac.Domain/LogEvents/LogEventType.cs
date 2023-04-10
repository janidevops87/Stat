namespace Statline.StatTrac.Domain.LogEvents;

public class LogEventType
{
    public LogEventTypeId LogEventTypeId { get; set; }
    public string? LogEventTypeName { get; set; }
    public DateTimeOffset? LastModified { get; set; }
    public short? UpdatedFlag { get; set; }
    public string? EventColor { get; set; }
    public string? Code { get; set; }
}
