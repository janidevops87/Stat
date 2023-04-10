using System;
using System.Collections.Generic;
using System.Text;
using MediatR;
using Statline.Common.Domain.Events;

namespace Statline.Common.Infrastructure.Domain.Events
{
    public interface IMediatrDomainEventNotification<out TEvent> : INotification
        where TEvent : DomainEvent
    {
        TEvent DomainEvent { get; }
    }
}
