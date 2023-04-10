using System;
using Statline.Common.Utilities;

namespace Statline.StatTrac.Api.Infrastructure.Http
{
    public class AuthenticationResult
    {
        public AuthenticationResult(
            string accessToken,
            string accessTokenType,
            DateTimeOffset expirationTime)
        {
            Check.NotEmpty(accessToken, nameof(accessToken));
            Check.NotEmpty(accessTokenType, nameof(accessTokenType));

            AccessToken = accessToken;
            AccessTokenType = accessTokenType;
            ExpirationTime = expirationTime;
        }

        public string AccessTokenType { get; }
        public string AccessToken { get; }
        public DateTimeOffset ExpirationTime { get; }
    }
}
