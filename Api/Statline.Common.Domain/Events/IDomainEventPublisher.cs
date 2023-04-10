using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace Statline.Common.Domain.Events
{
    public interface IDomainEventPublisher
    {
        Task PublishAsync(DomainEvent domainEvent);
    }
}
