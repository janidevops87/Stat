using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;

namespace Emailer.MessageProcessor.Domain
{
    public static class EmailMessageSenderServiceExtensions
    {
        public static async Task SendMessagesAsync(
            this IEmailMessageSenderService messageSender,
            IEnumerable<EmailMessage> messages,
            CancellationToken cancellationToken)
        {
            foreach (var message in messages)
            {
                await messageSender.SendMessageAsync(
                   message,
                   cancellationToken).ConfigureAwait(false);
            }
        }
    }
}
