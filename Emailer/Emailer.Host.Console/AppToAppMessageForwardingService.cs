using Emailer.LegacyBridge.App;
using Emailer.MessageProcessor.App;
using Microsoft.Extensions.Logging;
using System;
using System.Threading;
using System.Threading.Tasks;

namespace Emailer.Host.Console
{
    /// <summary>
    /// Glues two applications together so they can cooperate 
    /// in the singe application host.
    /// </summary>
    internal class AppToAppMessageForwardingService : IMessageForwardingService
    {
        private readonly MessageProcessorApp messageProcessorApp;
        private readonly ILogger logger;

        public AppToAppMessageForwardingService(
            MessageProcessorApp messageProcessorApp,
            ILogger<AppToAppMessageForwardingService> logger)
        {
            this.messageProcessorApp = messageProcessorApp;
            this.logger = logger;
        }

        public async Task ForwardMessageAsync(
            EmailMessage message,
            CancellationToken cancellationToken)
        {
            var messageInfo = new EmailMessageInfo(
                id: message.Id,
                from: message.From,
                to: message.To,
                cc: message.CC,
                bcc: message.Bcc,
                subject: message.Subject,
                body: message.Body);

            try
            {
                await messageProcessorApp.ProcessMessageAsync(
                    messageInfo,
                    cancellationToken);
            }
            // Swallow errors here to give other messages a chance 
            // to be processed.
            catch (Exception ex)
            {
                logger.LogError(ex,
                    "Failed processing message with id '{MessageId}': {ErrorMesssage}",
                    message.Id,
                    ex.Message);
            }
        }
    }
}
