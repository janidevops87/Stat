using Microsoft.Extensions.Logging;
using Statline.StatTrac.Domain.Referrals;

namespace Statline.StatTrac.App.ReferralProcessor;

internal static class LoggerExtensions
{
    public static void LogReferralAdded(
        this ILogger logger,
        ReferralId referralId)
    {
        logger.LogInformation(
                $"Added new referral id='{referralId}' to updated referrals repository.");
    }

    public static void LogReferralUpdated(
        this ILogger logger,
        ReferralId referralId)
    {
        logger.LogInformation(
                  $"Updated referral id='{referralId}' in updated referrals repository.");
    }

    public static void LogReferralNotChanged(
        this ILogger logger,
        ReferralId referralId)
    {
        logger.LogInformation(
                 $"Referral id='{referralId}' hasn't changed, won't update it.");
    }

    public static void LogReferralAlreadyExists(
       this ILogger logger,
       ReferralId referralId)
    {
        // TODO: Consider making this Information level.
        logger.LogWarning(
                 $"Referral id='{referralId}' already existed " +
                 $"when trying to create it. Will repeat with update now.");
    }

    public static void LogReferralIsOutdated(
       this ILogger logger,
       ReferralId referralId)
    {
        // TODO: Consider making this Information level.
        logger.LogWarning(
                 $"Referral id='{referralId}' was concurrently updated " +
                 $"after it was read. Will re-read and try to update again.");
    }

    public static void LogReferralRecycled(
       this ILogger logger,
       ReferralId referralId,
       bool existedInUpdatedDb)
    {
        if (existedInUpdatedDb)
        {
            logger.LogInformation(
                $"Referral id='{referralId}' is recycled and has been deleted " +
                $"from the updated referrals database.");
        }
        else
        {
            logger.LogInformation(
                $"Referral id='{referralId}' is recycled and is not in the updated " +
                $"referrals database, just skipping.");
        }
    }

    public static void LogReferralStatus(
       this ILogger logger,
       ReferralId referralId,
       ReferralStatus referralStatus)
    {
        logger.LogInformation(
                $"Referral id='{referralId}' has status: {referralStatus}");
    }

    public static void LogRetry(
        this ILogger logger,
        ReferralId referralId,
        TimeSpan delay,
        int retryNumber,
        int maxRetryCount)
    {
        logger.LogInformation(
                 $"Retrying to process referral id='{referralId}' in {delay}, " +
                 $"retry {retryNumber} of {maxRetryCount}.");
    }
}
