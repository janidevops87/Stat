using System.Collections.Generic;
using Statline.Common.Utilities;

namespace Statline.IdentityServer.IdentityServerConfig.App.Clients.Dto
{
    public class ClientPropertiesInfo
    {

        public ClientPropertiesInfo(
            string clientId,
            string clientName,
            string clientClaimsPrefix,
            int accessTokenLifetime,
            IEnumerable<string> allowedGrantTypes)
        {
            Check.NotEmpty(clientId, nameof(clientId));
            Check.NotEmpty(clientName, nameof(clientName));
            Check.BiggerOrEqual(accessTokenLifetime, other: 1, nameof(accessTokenLifetime));
            Check.HasNoEmpties(allowedGrantTypes, nameof(allowedGrantTypes));

            ClientId = clientId;
            ClientName = clientName;
            ClientClaimsPrefix = clientClaimsPrefix;
            AccessTokenLifetime = accessTokenLifetime;
            AllowedGrantTypes = allowedGrantTypes;
        }

        public string ClientId { get; }
        public string ClientName { get; }
        public string ClientClaimsPrefix { get; }
        public int AccessTokenLifetime { get; }
        public IEnumerable<string> AllowedGrantTypes { get; }
        public bool AlwaysSendClientClaims { get; set; }
        public bool AlwaysIncludeUserClaimsInIdToken { get; set; }
        public bool AllowAccessTokensViaBrowser { get; set; }
        public bool RequireConsent { get; set; }
        public bool AllowOfflineAccess { get; set; }
    }
}
