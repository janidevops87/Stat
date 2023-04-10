using System.Threading;
using System.Threading.Tasks;

namespace Statline.StatTracUploader.Domain.Main.Calls
{
    public interface ICallRepository
    {
        Task AddCallAsync(Call call, CancellationToken cancellationToken);
    }
}
