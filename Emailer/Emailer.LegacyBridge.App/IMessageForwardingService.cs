using System.Threading;
using System.Threading.Tasks;

namespace Emailer.LegacyBridge.App
{
    public interface IMessageForwardingService
    {
        Task ForwardMessageAsync(EmailMessage message, CancellationToken cancellationToken);
    }
}
