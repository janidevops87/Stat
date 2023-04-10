using System;
using System.Collections.Generic;
using System.Text;
using Statline.Common.Utilities;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Common;

namespace Statline.IdentityServer.IdentityAndAccess.Domain.Model.Command.Events
{
    public sealed class UserClaimRemoved : ClaimRemovedEvent
    {
        // TODO: Make internal when possible.
        public UserClaimRemoved(UserId userId, Claim claim)
            : base(claim)
        {
            Check.NotNull(userId, nameof(userId));
            UserId = userId;
        }

        public UserId UserId { get; }
    }
}
