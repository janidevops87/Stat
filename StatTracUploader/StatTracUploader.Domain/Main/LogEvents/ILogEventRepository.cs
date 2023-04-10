using System.Threading;
using System.Threading.Tasks;

namespace Statline.StatTracUploader.Domain.Main.LogEvents
{
    public interface ILogEventRepository
    {
        Task AddLogEventAsync(LogEvent logEvent, CancellationToken cancellationToken);
    }
}
