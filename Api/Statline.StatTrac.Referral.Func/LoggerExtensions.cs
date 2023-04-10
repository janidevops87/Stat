using Microsoft.Extensions.Logging;
using Statline.Common.AppModel.Environment;
using Statline.StatTrac.Api.Func.Model;
using Statline.StatTrac.Api.Infrastructure.RestClient.Model;
using System;

namespace Statline.StatTrac.Api.Func
{
    internal static class LoggerExtensions
    {
        public static void LogUnhandledException(
            this ILogger logger,
            Exception ex,
            ReferralQueueDto referralQueueDto)
        {
            logger.LogError(
                    eventId: 0,
                    message: "Unhandled exception when processing " +
                                "referral '{referralId}' with WRGID '{webReportGroupId}'.",
                    exception: ex,
                    args: new object[]
                    {
                        referralQueueDto.ReferralId,
                        referralQueueDto.WebReportGroupId
                    });
        }

        public static void LogEnvironment(
            this ILogger logger,
            IEnvironment environment)
        {
            logger.LogInformation($"Environment name is: {environment.EnvironmentName}.");
        }

        public static void LogProcessingResult(
            this ILogger logger,
            ReferralProcessingResult result,
            ReferralQueueDto referralQueueDto)
        {
            logger.LogInformation(
                "Update notification for " +
                "ReferralId={ReferralId}, WebReportGroupId={WebReportGroupId} " +
                "successfully forwarded to StatTrac referral processor API. " +
                "Response indicates processing status: {processingStatus}",
                referralQueueDto.ReferralId,
                referralQueueDto.WebReportGroupId,
                result.ProcessingStatus);
        }

        public static void LogQueueItem(
            this ILogger logger,
            ReferralQueueDto referralQueueDto)
        {
            logger.LogInformation(
                "Dequeued update notification for " +
                "ReferralId={ReferralId}, WebReportGroupId={WebReportGroupId}. " +
                "Forwarding to StatTrac referral processor API.",
                referralQueueDto.ReferralId,
                referralQueueDto.WebReportGroupId);
        }

        public static void LogPoisonQueueItem(
            this ILogger logger,
            ReferralQueueDto referralQueueDto)
        {
            logger.LogInformation(
                "Dequeued poison update notification for " +
                "ReferralId={ReferralId}, " +
                "WebReportGroupId={WebReportGroupId}, " +
                "RetryCount={RetryCount}, " +
                "IsDelayedRetry={IsDelayedRetry}.",
                referralQueueDto.ReferralId,
                referralQueueDto.WebReportGroupId,
                referralQueueDto.RetryCount,
                referralQueueDto.IsDelayedRetry);
        }

        public static void LogReQueuingItemToPoisonQueue(
           this ILogger logger,
           ReferralQueueDto referralQueueDto,
           TimeSpan delay)
        {
            logger.LogInformation(
                "Re-queuing poison update notification for " +
                "ReferralId={ReferralId}, " +
                "WebReportGroupId={WebReportGroupId}, " +
                "RetryCount={RetryCount} with delay {delay} " +
                "({delayInSeconds} seconds).",
                referralQueueDto.ReferralId,
                referralQueueDto.WebReportGroupId,
                referralQueueDto.RetryCount,
                delay,
                delay.TotalSeconds);
        }

        public static void LogApiHealthChecking(
           this ILogger logger, ReferralQueueDto referralQueueDto)
        {
            logger.LogInformation(
                "Checking API health, " +
                "ReferralId={ReferralId}, " +
                "WebReportGroupId={WebReportGroupId}, " +
                "RetryCount={RetryCount}.",
                referralQueueDto.ReferralId,
                referralQueueDto.WebReportGroupId,
                referralQueueDto.RetryCount);
        }

        public static void LogApiNotHealthy(
           this ILogger logger)
        {
            logger.LogWarning("The API is NOT healthy.");
        }

        public static void LogReQueuingItemToMainQueue(
           this ILogger logger,
           ReferralQueueDto referralQueueDto)
        {
            logger.LogInformation(
                "The API is healthy, re-queuing poison update notification for " +
                "ReferralId={ReferralId}, " +
                "WebReportGroupId={WebReportGroupId} " +
                "to the main queue.",
                referralQueueDto.ReferralId,
                referralQueueDto.WebReportGroupId);
        }

        public static void LogReQueuingItemToFailedQueue(
           this ILogger logger,
           ReferralQueueDto referralQueueDto,
           int maxRetryCount)
        {
            logger.LogInformation(
                "Retry count has reached maximum of {MaxRetryCount}, " +
                "queuing poison update notification for " +
                "ReferralId={ReferralId}, " +
                "WebReportGroupId={WebReportGroupId} " +
                "to the failed queue.",
                maxRetryCount,
                referralQueueDto.ReferralId,
                referralQueueDto.WebReportGroupId);
        }
    }
}
