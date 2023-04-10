using IdentityModel.Client;
using Statline.Common.Infrastructure.Networking.RestClient.Authentication;
using Statline.Common.Services;

namespace Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ApiClients.InContactApi.Authentication;

internal class ResourceOwnerPasswordAuthenticationProvider<TClient> :
    IAuthenticationProvider<TClient>
{
    internal const string TokenClientName = "ResourceOwnerPasswordAuthenticationProviderClient";

    private readonly HttpClient tokenClient;
    private readonly PasswordTokenRequest passwordTokenRequest;
    private readonly IDateTimeService dateTimeService;

    private AuthenticationResult? cachedAuthenticationResult;

    public ResourceOwnerPasswordAuthenticationProvider(
        IHttpClientFactory httpClientFactory,
        IOptions<ResourceOwnerPasswordAuthenticationOptions<TClient>> options,
        IDateTimeService dateTimeService)
    {
        Check.NotNull(httpClientFactory, nameof(httpClientFactory));
        Check.NotNull(options, nameof(options));
        Check.NotNull(dateTimeService, nameof(dateTimeService));

        tokenClient = httpClientFactory.CreateClient(TokenClientName);

        var optionsValue = options.Value;

        passwordTokenRequest = new PasswordTokenRequest
        {
            Address = optionsValue.TokenEndpointAddress,

            ClientId = optionsValue.ClientId,
            ClientSecret = optionsValue.ClientSecret,
            Scope = optionsValue.Scope,

            UserName = optionsValue.UserCredentials.UserName,
            Password = optionsValue.UserCredentials.Password,

            // InContact token server understands only
            // Base64(client_id + ":" + client_secret) format.
            AuthorizationHeaderStyle = BasicAuthenticationHeaderStyle.Rfc2617,
            ClientCredentialStyle = ClientCredentialStyle.AuthorizationHeader
        };

        this.dateTimeService = dateTimeService;
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

        var response = await tokenClient.RequestPasswordTokenAsync(passwordTokenRequest, cancellationToken).ConfigureAwait(false);

        if (response.IsError)
        {
            throw new InvalidOperationException(
                $"Could not retrieve access token. Error: {response.Error}; " +
                $"error description: {response.ErrorDescription}.",
                response.Exception);
        }

        var expirationTime =
            dateTimeService.GetCurrent()
                .AddSeconds(response.ExpiresIn)
                .ToUniversalTime();

        cachedAuthenticationResult = new AuthenticationResult(
            response.AccessToken,
            response.TokenType,
            expirationTime);

        return cachedAuthenticationResult;
    }
}
