using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using MediatR;
using Statline.Common.Domain.Events;
using Statline.Common.Utilities;

namespace Statline.Common.Infrastructure.Domain.Events
{
    public class MediatrDomainEventPublisher : IDomainEventPublisher
    {
        private readonly IMediator mediator;

        public MediatrDomainEventPublisher(IMediator mediator)
        {
            Check.NotNull(mediator, nameof(mediator));
            this.mediator = mediator;
        }

        public async Task PublishAsync(DomainEvent domainEvent)
        {
            Check.NotNull(domainEvent, nameof(domainEvent));

            INotification notification = WrapInNotification(domainEvent);

            await mediator.Publish(notification);
        }

        private static INotification WrapInNotification(DomainEvent domainEvent)
        {
            var openType = typeof(MediatrDomainEventNotification<>);
            var closedType = openType.MakeGenericType(domainEvent.GetType());

            var notification =
                (INotification)Activator.CreateInstance(closedType, domainEvent);

            return notification;
        }
    }
}
