namespace Statline.StatTrac.App.Heartbeat;

public interface ISqlServerHealthChecker
{
    Task<SqlServerHealthReport> CheckHealthAsync(string connectionString);
}
