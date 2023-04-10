using Statline.IdentityServer.IdentityServerConfig.Domain.Model;

namespace Statline.IdentityServer.IdentityServerConfig.App.Clients.Dto
{
    public class ClientSummaryInfo
    {
        public ClientSummaryInfo(
            string clientName, 
            string clientId, 
            int id)
        {
            ClientName = clientName;
            ClientId = clientId;
            Id = id;
        }

        public string ClientName { get; }
        public string ClientId { get; }
        public int Id { get; }
        public TenantId TenantId { get; internal set; }
    }
}
