using IdentityModel.Client;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Statline.Common.Infrastructure.Networking.RestClient;
using Statline.Common.Utilities;
using System;

namespace Statline.StatTracUploader.Infrastructure.Services.StatTracApi
{
    public static class ServiceCollectionExtensions
    {
        private const string TokenClientName = "StatTracUploaderTokenClient";

        public static void AddStatTracApiClient(
            this IServiceCollection services,
            IConfiguration clientConfig)
        {
            Check.NotNull(clientConfig, nameof(clientConfig));

            services
                .AddAccessTokenManagement(options =>
                {
                    var authConfig = clientConfig.GetSection("Authentication");
                    var tokenRequest = authConfig.Get<ClientCredentialsTokenRequest>();

                    if (tokenRequest is null)
                    {
                        throw new InvalidOperationException(
                            $"No authentication configuration found in configuration section '{authConfig.Path}'");
                    }

                    options.Client.Clients.Add(TokenClientName, tokenRequest);
                });

    
            services
                .AddRestServiceClient<
                    IStatTracApiClient, 
                    StatTracApiClient, 
                    RestServiceClientOptions<StatTracApiClient>>(clientConfig)
                .AddClientAccessTokenHandler(tokenClientName: TokenClientName);
        }
    }
}
