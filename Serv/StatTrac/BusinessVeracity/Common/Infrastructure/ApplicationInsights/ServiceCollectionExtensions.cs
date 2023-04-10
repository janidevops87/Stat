using Microsoft.ApplicationInsights.Extensibility;

namespace Microsoft.Extensions.DependencyInjection;

public static class ServiceCollectionExtensions
{
    public static void AddWebJobNameTelemetryInitializer(
        this IServiceCollection services,
        string webJobName)
    {
        Check.NotNull(services, nameof(services));
        Check.NotEmpty(webJobName, nameof(webJobName));

        services.AddSingleton<ITelemetryInitializer>(
            _ => new WebJobNameTelemetryInitializer(webJobName));
    }
}
