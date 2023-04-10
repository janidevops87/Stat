using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Microsoft.WindowsAzure.Storage.Queue;
using Statline.Common.Utilities;
using Statline.StatTrac.Api.Func.Infrastructure;
using Statline.StatTrac.Api.Func.Model;
using Statline.StatTrac.Api.Infrastructure.RestClient;
using System;
using System.Net.Http;
using System.Threading.Tasks;

namespace Statline.StatTrac.Api.Func
{
    internal class PoisonQueueProcessingApp
    {
        private readonly IStatTracApiClient apiClient;
        private readonly ILogger logger;
        private readonly PoisonQueueProcessingOptions options;

        public PoisonQueueProcessingApp(
            IStatTracApiClient apiClient,
            ILogger<PoisonQueueProcessingApp> logger,
            IOptions<PoisonQueueProcessingOptions> options)
        {
            Check.NotNull(apiClient, nameof(apiClient));
            Check.NotNull(logger, nameof(logger));
            Check.NotNull(options, nameof(options));
            this.apiClient = apiClient;
            this.logger = logger;
            this.options = options.Value;
        }

        public async Task ProcessPoisonItemAsync(
            ReferralQueueDto poisonQueueItem,
            CloudQueue poisonQueue,
            CloudQueue mainQueue,
            CloudQueue failedQueue)
        {
            Check.NotNull(poisonQueueItem, nameof(poisonQueueItem));
            Check.NotNull(poisonQueue, nameof(poisonQueue));
            Check.NotNull(mainQueue, nameof(mainQueue));
            Check.NotNull(failedQueue, nameof(failedQueue));

            logger.LogPoisonQueueItem(poisonQueueItem);

            // If got here after a delay.
            if (poisonQueueItem.IsDelayedRetry)
            {
                // We do two kinds of retries:
                // 1. If API reports to be healthy, 
                // try to process again. If that fails, 
                // we'll get here again with this item.
                // 2. Otherwise wait an check if the
                // API is healthy again.
                // 
                // This is why we increment retry count 
                // for both cases.
                poisonQueueItem.RetryCount++;

                logger.LogApiHealthChecking(poisonQueueItem);

                bool isApiHealthy = await CheckIfApiHealthyAsync(apiClient);

                if (isApiHealthy)
                {
                    logger.LogReQueuingItemToMainQueue(poisonQueueItem);

                    poisonQueueItem.IsDelayedRetry = false;

                    // Re-enqueue to the main queue.
                    await mainQueue.EnqueueObjectAsync(poisonQueueItem);
                }
                else // API is still unavailable, let's wait again.
                {
                    logger.LogApiNotHealthy();

                    await RetryOrGiveUp(poisonQueueItem, poisonQueue, failedQueue);
                }
            }
            else // We've just failed, let's wait.
            {
                await RetryOrGiveUp(poisonQueueItem, poisonQueue, failedQueue);
            }
        }

        private async Task RetryOrGiveUp(
            ReferralQueueDto poisonQueueItem,
            CloudQueue poisonQueue,
            CloudQueue failedQueue)
        {
            if (poisonQueueItem.RetryCount < options.MaxRetryCount)
            {
                poisonQueueItem.IsDelayedRetry = true;

                // Re-enqueue to the poison queue.
                await EnqueueWithDelayAsync(poisonQueueItem, poisonQueue);
            }
            else
            {
                logger.LogReQueuingItemToFailedQueue(
                    poisonQueueItem, 
                    options.MaxRetryCount);

                poisonQueueItem.IsDelayedRetry = false;

                await failedQueue.EnqueueObjectAsync(poisonQueueItem);
            }
        }

        private static async Task<bool> CheckIfApiHealthyAsync(IStatTracApiClient apiClient)
        {
            try
            {
                var healthReport = await apiClient.GetApiHealthReportAsync();
                return healthReport.IsHealthy;
            }
            catch (HttpRequestException)
            {
                return false;
            }
            catch (TimeoutException)
            {
                return false;
            }
        }

        private async Task EnqueueWithDelayAsync(
            ReferralQueueDto poisonQueueItem,
            CloudQueue poisonQueue)
        {
            TimeSpan delay = CalculateDelay(
                poisonQueueItem.RetryCount,
                options.MaxRetryDelay);

            logger.LogReQueuingItemToPoisonQueue(poisonQueueItem, delay);

            await poisonQueue.EnqueueObjectAsync(poisonQueueItem, delay);
        }


        private static TimeSpan CalculateDelay(
            int retryCount, TimeSpan maxDelay)
        {
            // Exponential back-off.
            var delay = TimeSpan.FromSeconds(Math.Pow(2, retryCount));

            return delay > maxDelay ? maxDelay : delay;
        }
    }
}
