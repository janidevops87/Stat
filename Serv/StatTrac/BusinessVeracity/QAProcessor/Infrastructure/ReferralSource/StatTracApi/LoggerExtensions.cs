﻿namespace Statline.StatTrac.BusinessVeracity.QAProcessor.Infrastructure.ReferralSource.StatTracApi;

internal static class LoggerExtensions
{
    public static void LogQueryingReferralsList(this ILogger logger)
    {
        logger.LogInformation("Querying high risk call referrals...");
    }

    public static void LogReferralCount(
       this ILogger logger,
       int referralCount)
    {
        logger.LogInformation(
            "Got {ReferralCount} high risk call referrals",
            referralCount);
    }

}
