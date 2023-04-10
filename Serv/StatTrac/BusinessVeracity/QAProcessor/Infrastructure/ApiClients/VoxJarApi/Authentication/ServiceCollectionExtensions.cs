using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Statline.Common.Infrastructure.Networking.RestClient.Authentication;
using System.Net;

namespace Statline.StatTrac.BusinessVeracity.QAProcessor.Infrastructure.ApiClients.VoxJarApi.Authentication;

internal static class ServiceCollectionExtensions
{
    public static IServiceCollection AddVoxJarAuthenticationProvider<TClient>(
       this IServiceCollection services,
       IConfiguration optionsConfig)
    {
        Check.NotNull(services, nameof(services));
        Check.NotNull(optionsConfig, nameof(optionsConfig));

        services
            .ConfigureWithDataAnnotationValidation<VoxJarAuthenticationOptions<TClient>>(optionsConfig);

        services
            .AddHttpClient(VoxJarAuthenticationProvider<TClient>.TokenClientName)
            .ConfigurePrimaryHttpMessageHandler(() => new HttpClientHandler
            {
                AutomaticDecompression = DecompressionMethods.GZip
            });

        services.AddAuthenticationProvider<VoxJarAuthenticationProvider<TClient>, TClient>();

        return services;
    }
}
