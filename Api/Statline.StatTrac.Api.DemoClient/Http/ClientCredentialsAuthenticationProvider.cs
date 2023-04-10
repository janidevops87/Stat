using IdentityModel.Client;
using System;
using System.Threading.Tasks;

namespace Statline.StatTrac.Api.DemoClient.Http
{
    public class ClientCredentialsAuthenticationProvider :
        IAuthenticationProvider,
        IDisposable
    {
         readonly TokenClient tokenClient;
         readonly string scope;

        public ClientCredentialsAuthenticationProvider(
            ClientCredentialsAuthenticationOptions options)
        {
            tokenClient = new TokenClient(
               options.TokenEndpointAddress,
               options.ClientId,
               options.ClientSecret);

            scope = options.Scope;
        }

        public async Task<AuthenticationResult> AuthenticateAsync()
        {
            var response = await tokenClient.RequestClientCredentialsAsync(scope).ConfigureAwait(false);

            return new AuthenticationResult(
                response.AccessToken,
                response.TokenType);
        }

        public void Dispose() => tokenClient?.Dispose();
    }
}
