using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Statline.Common.Domain.Entities;
using Statline.Common.Domain.Events;

namespace Statline.Common.Infrastructure.Domain.Events
{
    public static class DomainEventPublisherExtensions
    {
        public static async Task DispatchDomainEventsAsync(
            this IDomainEventPublisher publisher,
            DbContext ctx)
        {
            var domainEntities = ctx.ChangeTracker
                .Entries<IEntity>()
                .Where(x => x.Entity.DomainEvents.Any());

            var domainEvents = domainEntities
                .SelectMany(x => x.Entity.DomainEvents)
                .ToArray();

            domainEntities
                .ToList()
                .ForEach(entity => entity.Entity.ClearDomainEvents());

            // At first look it may seem that the order may
            // me important here, so publishing in parallel is not
            // a good idea. However, by definition domain events
            // should be asynchronous and not every handler implementation
            // can guarantee preserving the order.
            var tasks = domainEvents
                .Select(async domainEvent =>
                    // Await to preserve call stack during debugging.
                    await publisher.PublishAsync(domainEvent));

            await Task.WhenAll(tasks);
        }
    }
}
