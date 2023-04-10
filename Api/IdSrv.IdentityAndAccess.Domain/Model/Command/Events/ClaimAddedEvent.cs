using System;
using System.Collections.Generic;
using System.Text;
using Statline.Common.Domain.Events;
using Statline.Common.Utilities;

namespace Statline.IdentityServer.IdentityAndAccess.Domain.Model.Command.Events
{
    public abstract class ClaimAddedEvent : DomainEvent
    {
        protected ClaimAddedEvent(Claim claim)
        {
            Check.NotNull(claim, nameof(claim));
            AddedClaim = claim;
        }

        public Claim AddedClaim { get; }
    }
}
