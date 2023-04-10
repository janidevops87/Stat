using Emailer.MessageProcessor.Domain;
using Microsoft.Extensions.Options;
using Statline.Common.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace Emailer.MessageProcessor.App
{
    public class MessageProcessorApp
    {
        private readonly LogEventService logEventService = new();
        private readonly IEmailMessageSenderService messageSender;
        private readonly MessageLimitingDomain[] limitingDomains;

        public MessageProcessorApp(
            IEmailMessageSenderService messageSenderService,
            IOptions<MessageProcessorAppOptions> options)
        {
            Check.NotNull(messageSenderService, nameof(messageSenderService));
            Check.NotNull(options, nameof(options));

            messageSender = messageSenderService;

            limitingDomains = options.Value
                .LimitingDomains?
                .Where(ldo => ldo != null)
                .Select(ldo => new MessageLimitingDomain(ldo.Domain, ldo.SizeLimit))
                .ToArray() ?? Array.Empty<MessageLimitingDomain>();
        }

        public async Task ProcessMessageAsync(
            EmailMessageInfo messageInfo,
            CancellationToken cancellationToken)
        {
            Check.NotNull(messageInfo, nameof(messageInfo));

            var emailMessageBuilder = messageInfo.ToEmailMessageBuilder();

            // Initially suppose we have an email without limiting 
            // domain addresses.
            var normalToAddresses = emailMessageBuilder.ToAddresses.AsEnumerable();
            var normalAddressesEmailBuilder = emailMessageBuilder;

            // See if [To] email address contains a restricting provider
            // TODO: Its strange that we care only about 
            // [To] addresses and ignore [CC] and [Bcc]. But this is
            // how it was originally written...
            var limitedToAddresses =
                SelectLimitingDomainAddresses(emailMessageBuilder.ToAddresses);

            if (limitedToAddresses.Any())
            {
                // Now we know there are limiting domain addresses.
                // Lets check if there are normal addresses left.
                normalToAddresses = emailMessageBuilder.ToAddresses
                    .Except(limitedToAddresses.Select(a => a.Address)).ToArray();

                if (normalToAddresses.Any())
                {
                    // Replace the original message with a clone containing
                    // normal addresses only.
                    normalAddressesEmailBuilder =
                        emailMessageBuilder.CloneWithNewAddresses(normalToAddresses);
                }

                logEventService.MoveLogEventAndAddSubjectToStartOfBody(emailMessageBuilder);

                // Split emails with limiting domain To addresses
                // and send resulting chunk emails.
                var emailSplitter = new EmailSplitterService();

                var emailChunkBuilders = emailSplitter.SplitEmail(
                    emailMessageBuilder,
                    limitedToAddresses);

                // Clear subject because of redundancy and to 
                // make room for longer text area.
                ClearSubject(emailChunkBuilders);

                var emailChunks = emailChunkBuilders.Select(builder => builder.Build());

                await messageSender.SendMessagesAsync(
                    emailChunks, cancellationToken).ConfigureAwait(false);
            }

            // If all addresses were normal or some normal 
            // ones left, lets send a single email to them.
            if (normalToAddresses.Any())
            {
                logEventService.AddLogEventToSubjectAndBody(normalAddressesEmailBuilder);

                await messageSender.SendMessageAsync(
                     normalAddressesEmailBuilder.Build(), cancellationToken).ConfigureAwait(false);
            }
        }

        private static void ClearSubject(IEnumerable<EmailMessageBuilder> emailChunks)
        {
            foreach (var emailChunk in emailChunks)
            {
                emailChunk.SetSubject(string.Empty);
            }
        }

        private MessageLimitingDomainAddress[] SelectLimitingDomainAddresses(IEnumerable<EmailAddress> addresses)
        {
            return (from address in addresses
                    join domain in limitingDomains
                    on address.Host equals domain.Domain
                    select new MessageLimitingDomainAddress(address, domain.SizeLimit)).ToArray();
        }
    }
}
