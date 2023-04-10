using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Statline.Common.Services;
using Statline.StatTracUploader.App.Processor;
using System;
using System.Threading;
using System.Threading.Tasks;

namespace Statline.StatTracUploader.Infrastructure.Persistence.StatusProvider
{
    internal class HostServiceWorker : BackgroundService
    {
        private readonly IOptionsMonitor<HostServiceWorkerOptions> options;
        private readonly ILogger logger;
        private readonly IDateTimeService dateTimeService;
        private readonly MainRepositoryStatusProviderBase mainRepositoryStatusProvider;

        public HostServiceWorker(
            IOptionsMonitor<HostServiceWorkerOptions> options,
            ILogger<HostServiceWorker> logger,
            IMainRepositoryStatusProvider mainRepositoryStatusProvider,
            IDateTimeService dateTimeService)
        {
            this.options = options;
            this.logger = logger;
            this.dateTimeService = dateTimeService;
            // TODO: Think how to avoid coupling to concrete type.
            this.mainRepositoryStatusProvider =
                (MainRepositoryStatusProviderBase)mainRepositoryStatusProvider;
        }

        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            while (!stoppingToken.IsCancellationRequested)
            {
                try
                {
                    await ExecuteCoreAsync(stoppingToken);
                }
                catch (Exception ex)
                when (!(ex is OperationCanceledException && stoppingToken.IsCancellationRequested))
                {
                    logger.LogError(ex, "Unhandled exception in main repository status provider.");
                }
            }
        }

        private async Task ExecuteCoreAsync(CancellationToken stoppingToken)
        {
            var delay = options.CurrentValue.HealthCheckPeriod;

            var currentTime = dateTimeService.GetCurrent();

            logger.LogDebug("Main repository status provider worker running at: {time}", currentTime);

            await mainRepositoryStatusProvider.UpdateStatusAsync(
                nextCheckAt: currentTime + delay,
                stoppingToken);

            await Task.Delay(delay, stoppingToken);
        }
    }
}
