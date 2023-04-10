using Statline.Common.Utilities;
using Statline.IdentityServer.IdentityServerConfig.Domain.Model;

namespace Statline.IdentityServer.IdentityServerConfig.App.Clients.Dto
{
    public class NewClientInfo
    {
        public string ClientId { get; }
        public string ClientName { get; }
        public TenantId TenantId { get; }

        public NewClientInfo(
            string clientId,
            string clientName,
            TenantId tenantId)
        {
            Check.NotEmpty(clientId, nameof(clientId));
            Check.NotEmpty(clientName, nameof(clientName));
            Check.NotNull(tenantId, nameof(tenantId));

            ClientId = clientId;
            ClientName = clientName;
            TenantId = tenantId;
        }
    }
}
