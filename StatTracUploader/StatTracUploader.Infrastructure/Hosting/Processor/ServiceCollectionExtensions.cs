using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.DependencyInjection.Extensions;
using Statline.Common.Services;
using Statline.Common.Utilities;
using Statline.StatTracUploader.Infrastructure.Services;

namespace Statline.StatTracUploader.Infrastructure.Hosting.Processor
{
    public static class ServiceCollectionExtensions
    {
        public static void AddPendingReferralsProcessorBackgroundService(
            this IServiceCollection services,
            IConfiguration config)
        {
            Check.NotNull(services, nameof(services));
            Check.NotNull(config, nameof(config));

            services.Configure<HostServiceWorkerOptions>(config);
            services.AddHostedService<HostServiceWorker>();
            services.TryAddSingleton<IDateTimeService, DateTimeService>();
        }
    }
}
