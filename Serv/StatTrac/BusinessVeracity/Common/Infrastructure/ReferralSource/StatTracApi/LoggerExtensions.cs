namespace Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ReferralSource.StatTracApi;

internal static class LoggerExtensions
{
    public static void LogReferralNotFound(
        this ILogger logger,
        int referralId)
    {
        logger.LogWarning(
            "Referral with id = {ReferralId} wasn't found (deleted). Skipping the referral.",
            referralId);
    }
}
