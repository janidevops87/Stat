namespace Statline.StatTrac.App.LowLevel.LogEvents;

public class LogEventInfo
{
    public int Id { get; set; }
    public int? CallId { get; set; }
    public string? Type { get; set; }
    public DateTimeOffset? DateTime { get; set; }
    public int? Number { get; set; }
    public string? FromToPersonName { get; set; }
    public string? Description { get; set; }
}