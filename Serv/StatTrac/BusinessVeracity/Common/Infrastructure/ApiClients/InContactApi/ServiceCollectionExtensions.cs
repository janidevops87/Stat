using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Statline.Common.Infrastructure.Networking.RestClient;
using Statline.Common.Infrastructure.Networking.RestClient.Authentication;
using Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ApiClients.InContactApi.Authentication;

namespace Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ApiClients.InContactApi;

public static class ServiceCollectionExtensions
{
    public static IServiceCollection AddInContactApiClient(
        this IServiceCollection services,
        IConfiguration clientConfig,
        IConfiguration authConfig)
    {
        Check.NotNull(services, nameof(services));
        Check.NotNull(clientConfig, nameof(clientConfig));
        Check.NotNull(authConfig, nameof(authConfig));

        // While there is an extension for IHttpClientFactory from
        // IdentityModel library (which implements authentication and token
        // handling for OAuth2 (and password grant in particular)),
        // that extension doesn't support password grant.
        // More on this here: https://github.com/IdentityModel/IdentityModel.AspNetCore/issues/92
        // Though I understand the authors, I have to work around this.
        // I'm using very primitive implementation of token management for password grant,
        // which is intended solely for this application scenario and should not
        // be used in other applications.

        services
            .AddResourceOwnerPasswordAuthenticationProvider<IInContactApiClient>(authConfig)
            .AddRestServiceClient<
               IInContactApiClient,
               InContactApiClient,
               RestServiceClientOptions<InContactApiClient>>(clientConfig)
            .AddAuthenticationMessageHandler<IInContactApiClient>()
            .AddRetryPolicy<InContactApiClient>();

        return services;
    }


}
