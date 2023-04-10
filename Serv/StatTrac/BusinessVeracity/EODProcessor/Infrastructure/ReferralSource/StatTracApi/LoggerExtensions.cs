namespace Statline.StatTrac.BusinessVeracity.EodProcessor.Infrastructure.ReferralSource.StatTracApi;

internal static class LoggerExtensions
{
    public static void LogQueryingReferralsList(this ILogger logger)
    {
        logger.LogInformation("Querying updated referrals...");
    }

    public static void LogReferralCount(
        this ILogger logger,
        int referralCount)
    {
        logger.LogInformation(
            "Got {ReferralCount} updated referrals",
            referralCount);
    }
}
