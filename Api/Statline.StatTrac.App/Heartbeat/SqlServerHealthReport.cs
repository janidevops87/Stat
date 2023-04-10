namespace Statline.StatTrac.App.Heartbeat;

public class SqlServerHealthReport
{
    public static SqlServerHealthReport Healthy =
        new SqlServerHealthReport();

    public static SqlServerHealthReport FromException(Exception ex)
    {
        Check.NotNull(ex, nameof(ex));
        return new SqlServerHealthReport(ex.Message, ex);
    }

    private SqlServerHealthReport()
    {
    }

    public SqlServerHealthReport(
        string errorDescription,
        Exception exception)
    {
        Check.NotEmpty(errorDescription, nameof(errorDescription));
        Check.NotNull(exception, nameof(exception));

        ErrorDescription = errorDescription;
        Exception = exception;
    }

    public bool IsHealthy => Exception == null;
    public string? ErrorDescription { get; }
    public Exception? Exception { get; }

    public override string ToString()
    {
        return IsHealthy ?
            "Is healthy" :
            "Is NOT healthy: " + ErrorDescription;
    }
}
