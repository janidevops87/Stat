using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using Statline.Common.Utilities;

namespace Statline.Common.Domain.Events
{
    internal sealed class DomainEventCollection : Collection<DomainEvent>
    {
        public IReadOnlyCollection<DomainEvent> AsReadOnly()
        {
            return new ReadOnlyCollection<DomainEvent>(Items);
        }

        protected override void InsertItem(int index, DomainEvent item)
        {
            Check.NotNull(item, nameof(item));
            base.InsertItem(index, item);
        }

        protected override void SetItem(int index, DomainEvent item)
        {
            Check.NotNull(item, nameof(item));
            base.SetItem(index, item);
        }

        // TODO: Add optimizations such as lazy underlying list
        // allocation if needed.
    }
}
