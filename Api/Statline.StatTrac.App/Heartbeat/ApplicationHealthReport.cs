namespace Statline.StatTrac.App.Heartbeat;

public class ApplicationHealthReport
{
    public ApplicationHealthReport(
        DateTimeOffset timeStamp,
        SqlServerHealthReport onPremSqlServerHealth)
    {
        Check.NotNull(onPremSqlServerHealth, nameof(onPremSqlServerHealth));
        TimeStamp = timeStamp;
        OnPremSqlServerHealth = onPremSqlServerHealth;
    }

    public bool IsHealthy => OnPremSqlServerHealth.IsHealthy;
    public DateTimeOffset TimeStamp { get; }
    public SqlServerHealthReport OnPremSqlServerHealth { get; }
}