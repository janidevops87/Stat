using IdentityServer4.EntityFramework.Entities;
using Statline.Common.Domain.Events;
using Statline.Common.Utilities;

namespace Statline.IdentityServer.IdentityServerConfig.Domain.Model.Events
{
    public class ClientClaimRemovedEvent : DomainEvent
    {
        public ClientClaimRemovedEvent(
            int clientId,
            ClientClaim claim)
        {
            Check.BiggerOrEqual(clientId, other: 0, nameof(clientId));
            Check.NotNull(claim, nameof(claim));
            ClientId = clientId;
            RemovedClaim = claim;
        }

        public ClientClaim RemovedClaim { get; }
        public int ClientId { get; }
    }
}
