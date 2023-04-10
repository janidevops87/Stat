using Microsoft.ApplicationInsights.Extensibility;
using Microsoft.Extensions.DependencyInjection;
using Statline.Common.Utilities;

namespace Emailer.Host.Console
{
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
}
