namespace Statline.StatTrac.Api.ViewModels.Heartbeat;

public class SqlServerHealthReportViewModel
{
    public bool IsHealthy { get; set; }
    public string? ErrorDescription { get; set; }
}
