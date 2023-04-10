using Statline.Common.Services;
using Statline.Common.Utilities;
using Statline.StatTracUploader.App.Processor;
using System;
using System.Threading;
using System.Threading.Tasks;

namespace Statline.StatTracUploader.Infrastructure.Persistence.StatusProvider
{
    internal abstract class MainRepositoryStatusProviderBase : IMainRepositoryStatusProvider
    {
        private readonly IDateTimeService dateTimeService;

        protected MainRepositoryStatusProviderBase(IDateTimeService dateTimeService)
        {
            Check.NotNull(dateTimeService, nameof(dateTimeService));
            this.dateTimeService = dateTimeService;
        }

        private RepositoryStatus lastRepositoryStatus = new RepositoryStatus(
            RepositoryAvailability.Unknown, LastCheckAt: default, NextCheckAt: default);

        public RepositoryStatus GetRepositoryStatus()
        {
            // If this method is inlined by JIT, the latter can cache field
            // value in a register, so subsequent reads will be stale.
            // Doing volatile read prevents this.
            return Volatile.Read(ref lastRepositoryStatus);
        }

        internal async Task UpdateStatusAsync(
            DateTimeOffset nextCheckAt,
            CancellationToken cancellationToken)
        {
            var isHealthy = await CheckHealthAsync(cancellationToken).ConfigureAwait(false);

            var currentTime = dateTimeService.GetCurrent();

            lastRepositoryStatus = new RepositoryStatus(
                Availability:
                    isHealthy ?
                    RepositoryAvailability.Available :
                    RepositoryAvailability.NotAvailable,
                LastCheckAt: currentTime,
                nextCheckAt);
        }

        public abstract Task<bool> CheckHealthAsync(CancellationToken cancellationToken);
    }
}