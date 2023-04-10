namespace Statline.StatTrac.BusinessVeracity.QAProcessor.Application;

internal static class LoggerExtensions
{
    public static void LogRecordingNotFound(
        this ILogger logger,
        long contactId,
        int referralId,
        int callId)
    {
        logger.LogWarning(
            "Recording file wasn't found for contact id = {ContactId}, " +
                "referral id = {ReferralId}, " +
                "call id = {CallId}. Skipping the referral.",
            contactId,
            referralId,
            callId);
    }
}
