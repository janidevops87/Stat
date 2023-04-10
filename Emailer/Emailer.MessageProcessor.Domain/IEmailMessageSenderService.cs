using System.Threading;
using System.Threading.Tasks;

namespace Emailer.MessageProcessor.Domain
{
    public interface IEmailMessageSenderService
    {
        Task SendMessageAsync(EmailMessage message, CancellationToken cancellationToken);
    }
}
