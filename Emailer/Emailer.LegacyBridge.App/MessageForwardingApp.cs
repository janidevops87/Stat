using Microsoft.Extensions.Logging;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;

namespace Emailer.LegacyBridge.App
{
    public class MessageForwardingApp
    {
        private readonly IEmailMessageQueue emailMessageQueue;
        private readonly IMessageForwardingService messageForwardingService;
        private readonly ILogger logger;

        public MessageForwardingApp(
            IEmailMessageQueue emailMessageQueue,
            IMessageForwardingService messageForwardingService,
            ILogger<MessageForwardingApp> logger)
        {
            this.emailMessageQueue = emailMessageQueue;
            this.messageForwardingService = messageForwardingService;
            this.logger = logger;
        }

        public async Task ForwardPendingMessagesAsync(CancellationToken cancellationToken)
        {
            logger.LogTrace($"Checking the queue for new messages...");

            var messages = await emailMessageQueue.GetUnprocessedMessagesAsync(cancellationToken);

            await ProcessMessagesAsync(messages, cancellationToken);
        }

        private async Task ProcessMessagesAsync(
            IEnumerable<EmailMessage> messages,
            CancellationToken cancellationToken)
        {
            foreach (var message in messages)
            {
                await ForwardMessageAsync(message, cancellationToken);

                // If above fails, the message wont be marked processed.
                await emailMessageQueue.MarkMessageProcessedAsync(message, cancellationToken);
            }
        }

        private async Task ForwardMessageAsync(
            EmailMessage message,
            CancellationToken cancellationToken)
        {
            logger.LogInformation("Forwarding message with Id = '{Id}'", message.Id);

            await messageForwardingService.ForwardMessageAsync(message, cancellationToken);
        }
    }
}
