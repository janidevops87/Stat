using Statline.Common.Utilities;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Common;

namespace Statline.IdentityServer.IdentityAndAccess.Domain.Model.Command.Events
{
    public sealed class UserClaimAdded : ClaimAddedEvent
    {
        // TODO: Make internal when possible.
        public UserClaimAdded(UserId userId, Claim claim)
            : base(claim)
        {
            Check.NotNull(userId, nameof(userId));
            UserId = userId;
        }

        public UserId UserId { get; }
    }
}
