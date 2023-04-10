using Microsoft.Extensions.Options;
using Statline.Common.Services;
using Statline.Common.Utilities;
using System.Threading;
using System.Threading.Tasks;

namespace Statline.StatTracUploader.Infrastructure.Persistence.StatusProvider.DirectDbConnection
{
    internal class DirectDbConnectionMainRepositoryStatusProvider : MainRepositoryStatusProviderBase
    {
        private readonly IDatabaseHealthChecker databaseHealthChecker;
        private readonly IOptionsMonitor<DirectDbConnectionMainRepositoryStatusProviderOptions> options;

        public DirectDbConnectionMainRepositoryStatusProvider(
            IDatabaseHealthChecker databaseHealthChecker,
            IDateTimeService dateTimeService,
            IOptionsMonitor<DirectDbConnectionMainRepositoryStatusProviderOptions> options) 
            : base(dateTimeService)
        {
            Check.NotNull(databaseHealthChecker, nameof(databaseHealthChecker));
            Check.NotNull(options, nameof(options));
            this.databaseHealthChecker = databaseHealthChecker;
            this.options = options;
        }

        public override async Task<bool> CheckHealthAsync(CancellationToken cancellationToken)
        {
            var healthReport = await databaseHealthChecker.CheckHealthAsync(
                options.CurrentValue.ConnectionString,
                cancellationToken).ConfigureAwait(false);

            return healthReport.IsHealthy;
        }
    }
}
