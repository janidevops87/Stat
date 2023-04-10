using Statline.Common.Utilities;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;

namespace Emailer.MessageProcessor.Domain
{
    public class EmailMessage
    {
        public int Id { get; }
        public ReadOnlyCollection<EmailAddress> To { get; }
        public ReadOnlyCollection<EmailAddress> CC { get; }
        public ReadOnlyCollection<EmailAddress> Bcc { get; }
        public EmailAddress From { get; }
        public string Body { get; }
        public string Subject { get; }

        public EmailMessage(
            int id,
            EmailAddress from,
            IReadOnlyCollection<EmailAddress> to,
            IReadOnlyCollection<EmailAddress> cc,
            IReadOnlyCollection<EmailAddress> bcc,
            string? subject = null,
            string? body = null)
        {
            Check.NotNull(to, nameof(to));
            Check.NotEmpty(to, nameof(to));
            Check.HasNoNulls(to, nameof(to));
            Check.NotNull(from, nameof(from));
            Check.NotNull(cc, nameof(cc));
            Check.NotNull(bcc, nameof(bcc));

            Id = id;

            To = new ReadOnlyCollection<EmailAddress>(to.ToArray());
            CC = new ReadOnlyCollection<EmailAddress>(cc.ToArray());
            Bcc = new ReadOnlyCollection<EmailAddress>(bcc.ToArray());

            From = from;
            Body = body ?? string.Empty;
            Subject = subject ?? string.Empty;
        }

        public EmailMessage(
            int id,
            EmailAddress to,
            EmailAddress from)
            : this(id,
                  from,
                  to: new[] { Check.NotNull(to, nameof(to)) },
                  cc: Array.Empty<EmailAddress>(),
                  bcc: Array.Empty<EmailAddress>())
        {
        }
    }
}
