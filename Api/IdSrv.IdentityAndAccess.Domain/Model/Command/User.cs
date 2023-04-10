using System;
using System.Collections.Generic;
using Microsoft.AspNetCore.Identity;
using Statline.Common.Domain.Entities;
using Statline.Common.Domain.Events;
using Statline.Common.Utilities;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Common;

namespace Statline.IdentityServer.IdentityAndAccess.Domain.Model.Command
{
    public sealed class User : IdentityUser, IEntity
    {
        private readonly DomainEventsMixin domainEvents = new DomainEventsMixin();

        public string FirstName { get; set; }
        public string LastName { get; set; }

        public bool IsActive { get; private set; }
        public int? TenantId { get; private set; }
        public bool IsConfirmed => TenantId.HasValue;

        public IEnumerable<DomainEvent> DomainEvents => domainEvents.DomainEvents;

        internal User(string userName)
            : base(userName)
        {
        }

        private User() // For storage systems.
        {
        }

        public void Activate()
        {
            if (!IsConfirmed)
            {
                throw new InvalidOperationException(
                    "Can't activate unconfirmed user");
            }

            IsActive = true;
        }

        public void Deactivate()
        {
            IsActive = false;
        }

        internal void AssignTenantId(TenantId tenantId)
        {
            Check.NotNull(tenantId, nameof(tenantId));
            TenantId = tenantId;
        }

        private void AddDomainEvent(DomainEvent eventItem)
        {
            domainEvents.AddDomainEvent(eventItem);
        }
        
        public void ClearDomainEvents()
        {
            domainEvents.ClearDomainEvents();
        }
    }
}
