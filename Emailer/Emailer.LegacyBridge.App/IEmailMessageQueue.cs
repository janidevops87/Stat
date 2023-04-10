using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;

namespace Emailer.LegacyBridge.App
{
    public interface IEmailMessageQueue
    {
        Task<IEnumerable<EmailMessage>> GetUnprocessedMessagesAsync(CancellationToken cancellationToken);
        Task MarkMessageProcessedAsync(EmailMessage message, CancellationToken cancellationToken);
    }
}