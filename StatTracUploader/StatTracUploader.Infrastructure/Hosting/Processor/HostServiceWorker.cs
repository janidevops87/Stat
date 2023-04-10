using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Statline.Common.Services;
using Statline.StatTracUploader.App.Processor;
using System;
using System.Threading;
using System.Threading.Tasks;

namespace Statline.StatTracUploader.Infrastructure.Hosting.Processor
{
    internal class HostServiceWorker : BackgroundService
    {
        private readonly IServiceProvider serviceProvider;
        private readonly IOptionsMonitor<HostServiceWorkerOptions> options;
        private readonly ILogger logger;
        private readonly IDateTimeService dateTimeService;

        public HostServiceWorker(
            IServiceProvider serviceProvider,
            IOptionsMonitor<HostServiceWorkerOptions> options,
            ILogger<HostServiceWorker> logger,
            IDateTimeService dateTimeService)
        {
            this.serviceProvider = serviceProvider;
            this.options = options;
            this.logger = logger;
            this.dateTimeService = dateTimeService;
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
                    logger.LogError(ex, "Unhandled exception in pending referrals processor app.");
                }
            }
        }

        private async Task ExecuteCoreAsync(CancellationToken stoppingToken)
        {
            var delay = options.CurrentValue.ProcessingPeriod;

            var currentTime = dateTimeService.GetCurrent();

            logger.LogDebug("Pending referrals processor app worker running at: {time}", currentTime);

            using (var scope = serviceProvider.CreateScope())
            {
                var app = scope.ServiceProvider.GetRequiredService<PendingReferralsProcessorApp>();

                await app.ProcessAsync(stoppingToken);
            }

            await Task.Delay(delay, stoppingToken);
        }
    }
}
