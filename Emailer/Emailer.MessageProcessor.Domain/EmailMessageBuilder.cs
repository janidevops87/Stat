using Statline.Common.Utilities;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;

namespace Emailer.MessageProcessor.Domain
{
    public class EmailMessageBuilder
    {
        private readonly List<EmailAddress> toAddresses = new();
        private readonly List<EmailAddress> ccAddresses = new();
        private readonly List<EmailAddress> bccAddresses = new();

        public ReadOnlyCollection<EmailAddress> ToAddresses { get; }
        public ReadOnlyCollection<EmailAddress> CcAddresses { get; }
        public ReadOnlyCollection<EmailAddress> BccAddresses { get; }

        public int MessageId { get; private set; }
        public EmailAddress? FromAddress { get; private set; }
        public string Subject { get; private set; } = string.Empty;
        public string Body { get; private set; } = string.Empty;

        public EmailMessageBuilder()
        {
            ToAddresses = new ReadOnlyCollection<EmailAddress>(toAddresses);
            CcAddresses = new ReadOnlyCollection<EmailAddress>(ccAddresses);
            BccAddresses = new ReadOnlyCollection<EmailAddress>(bccAddresses);
        }

        public EmailMessageBuilder(EmailMessage message) : this()
        {
            Check.NotNull(message, nameof(message));

            toAddresses.AddRange(message.To);
            ccAddresses.AddRange(message.CC);
            bccAddresses.AddRange(message.Bcc);
            MessageId = message.Id;
            FromAddress = message.From;
            Subject = message.Subject;
            Body = message.Body;
        }

        public EmailMessageBuilder Clone()
        {
            var newBuilder = new EmailMessageBuilder();

            newBuilder.toAddresses.AddRange(toAddresses);
            newBuilder.ccAddresses.AddRange(ccAddresses);
            newBuilder.bccAddresses.AddRange(bccAddresses);
            newBuilder.MessageId = MessageId;
            newBuilder.FromAddress = FromAddress;
            newBuilder.Subject = Subject;
            newBuilder.Body = Body;

            return newBuilder;
        }

        public EmailMessageBuilder AddToAddress(EmailAddress address)
        {
            Check.NotNull(address, nameof(address));
            toAddresses.Add(address);
            return this;
        }

        public EmailMessageBuilder AddCcAddress(EmailAddress address)
        {
            Check.NotNull(address, nameof(address));
            ccAddresses.Add(address);
            return this;
        }

        public EmailMessageBuilder AddBccAddress(EmailAddress address)
        {
            Check.NotNull(address, nameof(address));
            bccAddresses.Add(address);
            return this;
        }

        public EmailMessageBuilder SetToAddresses(IEnumerable<EmailAddress> addresses)
        {
            Check.NotNull(addresses, nameof(addresses));
            toAddresses.Clear();
            toAddresses.AddRange(addresses.WhereNotNull());
            return this;
        }

        public EmailMessageBuilder SetToAddress(EmailAddress address)
        {
            Check.NotNull(address, nameof(address));
            toAddresses.Clear();
            toAddresses.Add(address);
            return this;
        }

        public EmailMessageBuilder SetCcAddresses(IEnumerable<EmailAddress> addresses)
        {
            Check.NotNull(addresses, nameof(addresses));
            ccAddresses.Clear();
            ccAddresses.AddRange(addresses.WhereNotNull());
            return this;
        }

        public EmailMessageBuilder SetCcAddress(EmailAddress address)
        {
            Check.NotNull(address, nameof(address));
            ccAddresses.Clear();
            ccAddresses.Add(address);
            return this;
        }

        public EmailMessageBuilder SetBccAddresses(IEnumerable<EmailAddress> addresses)
        {
            Check.NotNull(addresses, nameof(addresses));
            bccAddresses.Clear();
            bccAddresses.AddRange(addresses.WhereNotNull());
            return this;
        }

        public EmailMessageBuilder SetBccAddress(EmailAddress address)
        {
            Check.NotNull(address, nameof(address));
            bccAddresses.Clear();
            bccAddresses.Add(address);
            return this;
        }

        public EmailMessageBuilder SetFromAddress(EmailAddress address)
        {
            Check.NotNull(address, nameof(address));
            FromAddress = address;
            return this;
        }

        public EmailMessageBuilder SetSubject(string subject)
        {
            Check.NotNull(subject, nameof(subject));
            Subject = subject;
            return this;
        }

        public EmailMessageBuilder SetBody(string body)
        {
            Check.NotNull(body, nameof(body));
            Body = body;
            return this;
        }

        public EmailMessageBuilder SetMessageId(int id)
        {
            Check.Bigger(id, 0, nameof(id));
            MessageId = id;
            return this;
        }

        public EmailMessageBuilder Validate()
        {
            if (MessageId == 0)
            {
                throw new InvalidOperationException("Message id must be provided.");
            }

            if (!toAddresses.Any())
            {
                throw new InvalidOperationException(
                    "At least one recipient address must be provided.");
            }

            if (FromAddress is null)
            {
                throw new InvalidOperationException("The sender address must be provided.");
            }

            return this;
        }

        public EmailMessage Build()
        {
            Validate();

            return new EmailMessage(
                MessageId,
                FromAddress!,
                toAddresses,
                ccAddresses,
                bccAddresses,
                Subject,
                Body);
        }
    }
}
