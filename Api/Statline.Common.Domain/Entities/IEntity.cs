using System;
using System.Collections.Generic;
using System.Text;
using Statline.Common.Domain.Events;

namespace Statline.Common.Domain.Entities
{
    public interface IEntity
    {
        IEnumerable<DomainEvent> DomainEvents { get; }
        void ClearDomainEvents();
    }
}
