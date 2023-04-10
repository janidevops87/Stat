using Statline.Common.Services;
using Statline.Common.Utilities;
using Statline.StatTracUploader.Infrastructure.Services.StatTracApi;
using System.Threading;
using System.Threading.Tasks;

namespace Statline.StatTracUploader.Infrastructure.Persistence.StatusProvider.StatTracApi
{
    internal class StatTracApiMainRepositoryStatusProvider : MainRepositoryStatusProviderBase
    {
        private readonly IStatTracApiClient statTracApiClient;

        public StatTracApiMainRepositoryStatusProvider(
            IDateTimeService dateTimeService,
            IStatTracApiClient statTracApiClient) 
            : base(dateTimeService)
        {
            Check.NotNull(statTracApiClient, nameof(statTracApiClient));
            this.statTracApiClient = statTracApiClient;
        }

        public override async Task<bool> CheckHealthAsync(CancellationToken cancellationToken)
        {
            var healthReport = await statTracApiClient.GetApiHealthReportAsync(cancellationToken);
            return healthReport.OnPremSqlServerHealth.IsHealthy;
        }
    }
}
