using System.Threading;
using System.Threading.Tasks;

namespace Statline.StatTracUploader.Infrastructure.Persistence.StatusProvider.DirectDbConnection
{
    internal interface IDatabaseHealthChecker
    {
        Task<DatabaseHealthReport> CheckHealthAsync(
            string connectionString, 
            CancellationToken cancellationToken);
    }
}
