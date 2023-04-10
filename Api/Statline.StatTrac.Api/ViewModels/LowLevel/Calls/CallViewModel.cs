namespace Statline.StatTrac.Api.ViewModels.LowLevel.Calls;

public class CallViewModel
{
    public int Id { get; set; }
    public string? CallNumber { get; set; }
    public string? Type { get; set; }
    public DateTimeOffset? DateTime { get; set; }
    public TimeSpan? TotalTime { get; set; }
}
