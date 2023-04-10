using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Statline.Common.Infrastructure.Networking.RestClient;
using Statline.Common.Infrastructure.Networking.RestClient.Authentication;
using Statline.StatTrac.BusinessVeracity.QAProcessor.Infrastructure.ApiClients.VoxJarApi.Authentication;
using System.Net;

namespace Statline.StatTrac.BusinessVeracity.QAProcessor.Infrastructure.ApiClients.VoxJarApi;

public static class ServiceCollectionExtensions
{
    public static IServiceCollection AddVoxJarApiClient(
        this IServiceCollection services,
        IConfiguration clientConfig,
        IConfiguration authConfig)
    {
        Check.NotNull(services, nameof(services));
        Check.NotNull(clientConfig, nameof(clientConfig));
        Check.NotNull(authConfig, nameof(authConfig));

        services
            // VoxJar API uses its own non-standard token service
            .AddVoxJarAuthenticationProvider<IVoxJarApiClient>(authConfig)
            .AddRestServiceClient<
               IVoxJarApiClient,
               VoxJarApiClient,
               RestServiceClientOptions<VoxJarApiClient>>(clientConfig)
            .ConfigurePrimaryHttpMessageHandler(() => new HttpClientHandler
            {
                AutomaticDecompression = DecompressionMethods.GZip
            })
            .AddAuthenticationMessageHandler<IVoxJarApiClient>()
            .AddRetryPolicy<VoxJarApiClient>();

        return services;
    }
}
