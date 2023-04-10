using System;
using System.Collections.Generic;
using System.Text;
using Statline.Common.Domain.Events;
using Statline.Common.Utilities;

namespace Statline.IdentityServer.IdentityAndAccess.Domain.Model.Command.Events
{
    public abstract class ClaimRemovedEvent : DomainEvent
    {
        protected ClaimRemovedEvent(Claim claim)
        {
            Check.NotNull(claim, nameof(claim));
            RemovedClaim = claim;
        }

        public Claim RemovedClaim { get; }
    }
}
