namespace Statline.StatTrac.Api.ViewModels.LowLevel.LogEvents;

public class LogEventViewModel
{
    public int Id { get; set; }
    public int? CallId { get; set; }
    public string? Type { get; set; }
    public DateTimeOffset? DateTime { get; set; }
    public int? Number { get; set; }
    public string? FromToPersonName { get; set; }
    public string? Description { get; set; }
}