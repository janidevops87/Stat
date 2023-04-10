using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.DependencyInjection.Extensions;
using Statline.Common.Services;
using Statline.Common.Utilities;
using Statline.StatTracUploader.App.Processor;
using Statline.StatTracUploader.Infrastructure.Services;
using Statline.StatTracUploader.Infrastructure.Services.StatTracApi;

namespace Statline.StatTracUploader.Infrastructure.Persistence.StatusProvider.StatTracApi
{
    public static class ServiceCollectionExtensions
    {
        public static void AddStatTracApiMainRepositoryStatusProvider(
          this IServiceCollection services,
           IConfiguration mainRepositoryConfig)
        {
            Check.NotNull(services, nameof(services));
            Check.NotNull(mainRepositoryConfig, nameof(mainRepositoryConfig));

            services.Configure<HostServiceWorkerOptions>(mainRepositoryConfig);

            services.AddStatTracApiClient(
                clientConfig: mainRepositoryConfig.GetSection("StatTracApiClient"));

            services.AddHostedService<HostServiceWorker>();
            services.TryAddSingleton<IMainRepositoryStatusProvider, StatTracApiMainRepositoryStatusProvider>();
            services.TryAddSingleton<IDateTimeService, DateTimeService>();
        }
    }
}
