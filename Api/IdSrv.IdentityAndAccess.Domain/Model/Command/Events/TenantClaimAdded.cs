using Statline.Common.Utilities;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Common;

namespace Statline.IdentityServer.IdentityAndAccess.Domain.Model.Command.Events
{
    public sealed class TenantClaimAdded : ClaimAddedEvent
    {
        internal TenantClaimAdded(TenantId tenantId, Claim claim) 
            : base(claim)
        {
            Check.NotNull(tenantId, nameof(tenantId));
            TenantId = tenantId;
        }

        public TenantId TenantId { get; }
    }
}
