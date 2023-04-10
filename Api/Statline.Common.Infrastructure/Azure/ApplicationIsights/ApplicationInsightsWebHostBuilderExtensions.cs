using Microsoft.ApplicationInsights.AspNetCore.Extensions;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.DependencyInjection;
using Statline.Common.Utilities;

namespace Statline.Common.Infrastructure.Azure.ApplicationIsights
{
    public static class ApplicationInsightsWebHostBuilderExtensions
    {
        /// <summary>
        /// Configures <see cref="IWebHostBuilder"/> to use Application Insights services.
        /// </summary>
        /// <param name="webHostBuilder">The <see cref="IWebHostBuilder"/> instance.</param>
        /// <param name="configSectionName">Configuration section name.</param>
        /// <returns>The <see cref="IWebHostBuilder"/>.</returns>
        public static IWebHostBuilder UseApplicationInsightsWithConfig(
            this IWebHostBuilder webHostBuilder, 
            string configSectionName)
        {
            Check.NotEmpty(configSectionName, nameof(configSectionName));

            return webHostBuilder
                .ConfigureServices((context, services) =>
               {
                   services.Configure<ApplicationInsightsServiceOptions>(
                       context.Configuration.GetSection(configSectionName));
               })
               .UseApplicationInsights();
        }
    }
}
