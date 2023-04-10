namespace Statline.StatTrac.Api.ViewModels.Heartbeat;

public class ApplicationHealthReportViewModel
{
    public bool IsHealthy { get; set; }
    public DateTimeOffset TimeStamp { get; set; }
    public SqlServerHealthReportViewModel OnPremSqlServerHealth { get; set; }
}
