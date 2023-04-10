using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Statline.Common.Infrastructure.Networking.RestClient.Authentication;

namespace Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ApiClients.InContactApi.Authentication;

internal static class ServiceCollectionExtensions
{
    public static IServiceCollection AddResourceOwnerPasswordAuthenticationProvider<TClient>(
       this IServiceCollection services,
       IConfiguration optionsConfig)
    {
        Check.NotNull(services, nameof(services));
        Check.NotNull(optionsConfig, nameof(optionsConfig));

        services
            .ConfigureWithDataAnnotationValidation<ResourceOwnerPasswordAuthenticationOptions<TClient>>(optionsConfig);

        services.AddHttpClient(ResourceOwnerPasswordAuthenticationProvider<TClient>.TokenClientName);
        services.AddAuthenticationProvider<ResourceOwnerPasswordAuthenticationProvider<TClient>, TClient>();

        return services;
    }
}
