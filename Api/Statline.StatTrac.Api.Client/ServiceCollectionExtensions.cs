using IdentityModel.Client;
using Microsoft.Extensions.Configuration;
using Statline.Common.Infrastructure.Networking.RestClient;
using Statline.StatTrac.Api.Client;

namespace Microsoft.Extensions.DependencyInjection;

public static class ServiceCollectionExtensions
{
    private const string TokenClientName = "StatTracApiTokenClient";

    public static void AddStatTracApiClient(
        this IServiceCollection services,
        IConfiguration clientConfig,
        IConfiguration authConfig)
    {
        Check.NotNull(services);
        Check.NotNull(clientConfig);
        Check.NotNull(authConfig);

        services
            .AddAccessTokenManagement(options =>
            {
                var tokenRequest = authConfig.Get<ClientCredentialsTokenRequest>();

                if (tokenRequest is null)
                {
                    throw new InvalidOperationException(
                        $"No authentication configuration found in " +
                        $"configuration section '{(authConfig as IConfigurationSection)?.Path}'");
                }

                options.Client.Clients.Add(TokenClientName, tokenRequest);
            });

        services
            .AddRestServiceClient<
                IStatTracApiClient,
                StatTracApiClient,
                RestServiceClientOptions<StatTracApiClient>>(clientConfig)
            // NOTE: If Unauthorized response is received, the token handler
            // will retry once again after forcibly renewing the token.
            // This may add to the retry policy added next (depending on the policy).
            .AddClientAccessTokenHandler(tokenClientName: TokenClientName)
            .AddRetryPolicy<StatTracApiClient>();
    }
}
