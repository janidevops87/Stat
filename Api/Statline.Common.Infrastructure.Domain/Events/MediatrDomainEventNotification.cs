using MediatR;
using Statline.Common.Domain.Events;
using Statline.Common.Utilities;

namespace Statline.Common.Infrastructure.Domain.Events
{
    public class MediatrDomainEventNotification<TEvent> : 
        IMediatrDomainEventNotification<TEvent>
        where TEvent : DomainEvent
    {
        public MediatrDomainEventNotification(TEvent domainEvent)
        {
            Check.NotNull(domainEvent, nameof(domainEvent));
            DomainEvent = domainEvent;
        }

        public TEvent DomainEvent { get; }
    }
}
