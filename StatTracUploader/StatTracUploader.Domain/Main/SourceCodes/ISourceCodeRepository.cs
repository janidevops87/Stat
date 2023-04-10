using System.Threading;
using System.Threading.Tasks;

namespace Statline.StatTracUploader.Domain.Main.SourceCodes
{
    public interface ISourceCodeRepository
    {
        Task<int> FindSourceCodeIdByNameAsync(string sourceCode, CancellationToken cancellationToken);
    }
}
