using Statline.Common.Infrastructure.Networking.RestClient.Authentication;
using Statline.StatTrac.BusinessVeracity.QAProcessor.Infrastructure.ApiClients.VoxJarApi.Dto.Common;

namespace Statline.StatTrac.BusinessVeracity.QAProcessor.Infrastructure.ApiClients.VoxJarApi.Authentication;

internal class VoxJarAuthenticationProvider<TClient> :
    IAuthenticationProvider<TClient>
{

#pragma warning disable IDE1006 // Naming Styles
    private class VoxJarApiData
    {
        public VoxJarTokenInfo signInWithRefreshToken { get; set; } = default!;
    }

    private class VoxJarTokenInfo
    {
        public DateTimeOffset expiresAt { get; set; }

        public string token { get; set; } = default!;
    }
#pragma warning restore IDE1006 // Naming Styles

    internal const string TokenClientName = "VoxJarAuthenticationProviderClient";

    private readonly HttpClient tokenClient;
    private readonly string refreshToken;

    private AuthenticationResult? cachedAuthenticationResult;

    public VoxJarAuthenticationProvider(
        IHttpClientFactory httpClientFactory,
        IOptions<VoxJarAuthenticationOptions<TClient>> options)
    {
        Check.NotNull(httpClientFactory, nameof(httpClientFactory));
        Check.NotNull(options, nameof(options));

        tokenClient = httpClientFactory.CreateClient(TokenClientName);
        tokenClient.BaseAddress = options.Value.TokenEndpointAddress;

        refreshToken = options.Value.RefreshToken;
    }

    public async ValueTask<AuthenticationResult> AuthenticateAsync(CancellationToken cancellationToken)
    {
        if (cachedAuthenticationResult is not null)
        {
            // This is an intensional simplification. For this app's
            // goal it's OK to never refresh cached token,
            // as the app doesn't run continuously. 
            return cachedAuthenticationResult;
        }

        var body = new
        {
            query = @"mutation($refreshToken: String!){
                    signInWithRefreshToken(refreshToken: $refreshToken) {
                        token
                        expiresAt
                       }
                }",
            variables = new { refreshToken }
        };

        var voxJarResponse = await tokenClient.SendAndUnwrapResultContentAsync<VoxJarResponse<VoxJarApiData>>(
            requestUri: new Uri("", UriKind.Relative),
            HttpMethod.Post,
            content: body,
            cancellationToken).ConfigureAwait(false);

        voxJarResponse.EnsureNoErrors();

        var voxJarToken = voxJarResponse.data?.signInWithRefreshToken;

        if (voxJarToken is null)
        {
            throw new InvalidOperationException("No security token was found in the response");
        }

        cachedAuthenticationResult = new AuthenticationResult(
            credentials: voxJarToken.token,
            scheme: "Bearer",
            expirationTime: voxJarToken.expiresAt);

        return cachedAuthenticationResult;
    }
}
