using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;

namespace Emailer.LegacyBridge.Infrastructure.EmailMessageQueue.LegacyQueue
{
    internal interface ILegacyMessageQueue
    {
        Task<IEnumerable<Message>> GetUnprocessedMessagesAsync(CancellationToken cancellationToken);
        Task MarkMessageProcessedAsync(int messageId, CancellationToken cancellationToken);
    }
}