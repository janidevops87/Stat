using Microsoft.ApplicationInsights.Channel;

namespace Microsoft.ApplicationInsights.Extensibility;

// All Web Jobs are shown on the Application Map under
// same name of the hosting app service.
// This telemetry initializer sets the name to the name of the application/web job.
// https://github.com/microsoft/ApplicationInsights-dotnet/issues/2335
// https://docs.microsoft.com/en-us/azure/azure-monitor/app/app-map?tabs=net#set-or-override-cloud-role-name
//
// Example of how WebJobs SDK uses this approach to set slot name:
// https://github.com/Azure/azure-webjobs-sdk/blob/master/src/Microsoft.Azure.WebJobs.Logging.ApplicationInsights/Initializers/WebJobsRoleEnvironmentTelmetryInitializer.cs
internal class WebJobNameTelemetryInitializer : ITelemetryInitializer
{
    private readonly string webJobName;

    public WebJobNameTelemetryInitializer(string webJobName)
    {
        this.webJobName = Check.NotEmpty(webJobName, nameof(webJobName));
    }

    public void Initialize(ITelemetry telemetry)
    {
        telemetry.Context.Cloud.RoleName = webJobName;
    }
}
