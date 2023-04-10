using Emailer.LegacyBridge.App;
using Emailer.LegacyBridge.Infrastructure.EmailMessageQueue.LegacyQueue;
using Emailer.LegacyBridge.Service;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;

namespace Emailer.LegacyBridge.Infrastructure.EmailMessageQueue
{
    internal class EmailMessageQueueAdapter : IEmailMessageQueue
    {
        private readonly ILegacyMessageQueue legacyMessageQueue;
        private readonly ModelTranslator modelTranslator;

        public EmailMessageQueueAdapter(
            ILegacyMessageQueue legacyMessageQueue)
        {
            this.legacyMessageQueue = legacyMessageQueue;
            modelTranslator = new ModelTranslator();
        }

        public async Task<IEnumerable<EmailMessage>> GetUnprocessedMessagesAsync(CancellationToken cancellationToken)
        {
            var messages = await legacyMessageQueue.GetUnprocessedMessagesAsync(cancellationToken).ConfigureAwait(false);
            return modelTranslator.ToEmailMessages(messages);
        }

        public async Task MarkMessageProcessedAsync(EmailMessage message, CancellationToken cancellationToken)
        {
            await legacyMessageQueue.MarkMessageProcessedAsync(message.Id, cancellationToken).ConfigureAwait(false);
        }
    }
}
