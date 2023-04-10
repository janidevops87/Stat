using Microsoft.ApplicationInsights.Channel;
using Microsoft.ApplicationInsights.Extensibility;

public class AppInsightTelemetryInitializer : ITelemetryInitializer
{
    public void Initialize(ITelemetry telemetry)
    {
        // set custom role name here
        telemetry.Context.Cloud.RoleName = "Statline Access Portal";
    }
}