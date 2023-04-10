using Statline.StatTrac.Api.DemoClient.Utilities;

namespace Statline.StatTrac.Api.DemoClient.Http
{
    public class AuthenticationResult
    {
        public AuthenticationResult(
            string accessToken,
            string accessTokenType)
        {
            Check.NotEmpty(accessToken, nameof(accessToken));
            Check.NotEmpty(accessTokenType, nameof(accessTokenType));

            AccessToken = accessToken;
            AccessTokenType = accessTokenType;
        }

        public string AccessTokenType { get; }
        public string AccessToken { get; }
    }
}
