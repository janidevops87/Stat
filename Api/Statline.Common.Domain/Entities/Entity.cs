using System;
using System.Collections.Generic;
using System.Text;
using Statline.Common.Domain.Events;

namespace Statline.Common.Domain.Entities
{
    public abstract class Entity : IEntity
    {
        // Use the mixin here just to avoid code duplication.
        private readonly DomainEventsMixin domainEvents = new DomainEventsMixin();

        public IEnumerable<DomainEvent> DomainEvents => domainEvents.DomainEvents;

        public void ClearDomainEvents() => 
            domainEvents.ClearDomainEvents();

        protected void AddDomainEvent(DomainEvent eventItem) => 
            domainEvents.AddDomainEvent(eventItem);
        
    }
}
