using Microsoft.Extensions.Configuration;
using Statline.Common.Utilities;
using Statline.StatTrac.Api.Infrastructure.RestClient;

namespace Microsoft.Extensions.DependencyInjection
{
    public static class StatTracApiClientServiceCollectionExtensions
    {
        public static void AddStatTracApiClient(
            this IServiceCollection services,
            IConfiguration config)
        {
            Check.NotNull(services, nameof(services));
            Check.NotNull(config, nameof(config));

            services.Configure<StatTracApiClientOptions>(config);
            services.AddSingleton<IStatTracApiClient, StatTracApiClient>();
        }
    }
}
