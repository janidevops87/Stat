namespace Statline.StatTrac.App.LowLevel.Calls;

public class CallInfo
{
    // Add more properties if needed.
    public int Id { get; set; }
    public string? CallNumber { get; set; }
    public string? Type { get; set; }
    public DateTimeOffset? DateTime { get; set; }
    public TimeSpan? TotalTime { get; set; }
}