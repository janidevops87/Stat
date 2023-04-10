using IdentityServer4.EntityFramework.Entities;
using Statline.Common.Domain.Events;
using Statline.Common.Utilities;

namespace Statline.IdentityServer.IdentityServerConfig.Domain.Model.Events
{
    public class ClientClaimAddedEvent : DomainEvent
    {
        public ClientClaimAddedEvent(
            int clientId,
            ClientClaim claim)
        {
            Check.BiggerOrEqual(clientId, other: 0, nameof(clientId));
            Check.NotNull(claim, nameof(claim));
            ClientId = clientId;
            AddedClaim = claim;
        }

        public ClientClaim AddedClaim { get; }
        public int ClientId { get; }
    }
}
