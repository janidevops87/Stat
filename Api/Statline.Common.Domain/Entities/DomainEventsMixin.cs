using System;
using System.Collections.Generic;
using System.Text;
using Statline.Common.Domain.Events;

namespace Statline.Common.Domain.Entities
{
    /// <summary>
    /// Allows adding (via composition) domain events support to entities which
    /// can't be inherited from <see cref="Entity"/> class
    /// because they already inherit from a third-party class.
    /// </summary>
    public sealed class DomainEventsMixin
    {
        private readonly DomainEventCollection domainEvents = new DomainEventCollection();

        public IEnumerable<DomainEvent> DomainEvents => domainEvents.AsReadOnly();

        public void AddDomainEvent(DomainEvent eventItem)
        {
            domainEvents.Add(eventItem);
        }

        public void ClearDomainEvents()
        {
            domainEvents.Clear();
        }
    }
}
