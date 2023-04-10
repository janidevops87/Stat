using System;
using System.Threading;
using System.Threading.Tasks;
using IdentityModel.Client;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Statline.Common.Services;
using Statline.Common.Utilities;

namespace Statline.StatTrac.Api.Infrastructure.Http
{
    public class ClientCredentialsAuthenticationProvider :
        IAuthenticationProvider,
        IDisposable
    {
        private readonly TokenClient tokenClient;
        private readonly string scope;
        private readonly IDateTimeService dateTimeService;
        private readonly ILogger logger;
        private AuthenticationResult cachedAuthenticationResult;
        public ClientCredentialsAuthenticationProvider(
            IOptions<ClientCredentialsAuthenticationOptions> options,
            IDateTimeService dateTimeService,
            ILogger<ClientCredentialsAuthenticationProvider> logger)
        {
            Check.NotNull(options, nameof(options));
            Check.NotNull(dateTimeService, nameof(dateTimeService));
            Check.NotNull(logger, nameof(logger));

            var optionsValue = options.Value;

            tokenClient = new TokenClient(
               optionsValue.TokenEndpointAddress,
               optionsValue.ClientId,
               optionsValue.ClientSecret);

            scope = optionsValue.Scope;

            this.dateTimeService = dateTimeService;
            this.logger = logger;

            cachedAuthenticationResult = new AuthenticationResult(
                accessToken: "ExpiredToken",
                accessTokenType: "ExpiredAccessTokenType",
                expirationTime: default);

            this.logger = logger;
        }

        public async Task<AuthenticationResult> AuthenticateAsync()
        {
            // TODO: Consider moving token caching to a decorator class.
            var authResult = Volatile.Read(ref cachedAuthenticationResult);

            if (authResult.ExpirationTime <= dateTimeService.GetCurrent())
            {
                logger.LogDebug("Cached access token is expired, obtaining new one.");

                // In case of concurrent calls we use the lock-less strategy,
                // when we're OK if we do redundant calls but avoid
                // any locks and synchronization.
                var response = await tokenClient.RequestClientCredentialsAsync(scope).ConfigureAwait(false);

                if (response.IsError)
                {
                    throw new InvalidOperationException(
                        $"Could not retrieve access token.", response.Exception);
                }

                var expirationTime =
                    dateTimeService.GetCurrent()
                        .AddSeconds(response.ExpiresIn)
                        .ToUniversalTime();

                authResult = new AuthenticationResult(
                    response.AccessToken,
                    response.TokenType,
                    expirationTime);

                // Again, we don't care much about possible
                // concurrent assignment. The last just wins.
                cachedAuthenticationResult = authResult;
            }
            else
            {
                logger.LogDebug("Cached access token is not expired, reusing it.");
            }

            return authResult;
        }

        public void Dispose() => tokenClient?.Dispose();
    }
}
