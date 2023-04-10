namespace Statline.StatTrac.App.Heartbeat;

public class HeartbeatApplicationOptions
{
    public string OnPremSqlServerConnectionString { get; set; }

    public void Validate(string referencingPath)
    {
        Check.NotEmpty(referencingPath, nameof(referencingPath));
        Check.NotEmpty(OnPremSqlServerConnectionString,
            referencingPath + "." + nameof(OnPremSqlServerConnectionString));
    }
}
