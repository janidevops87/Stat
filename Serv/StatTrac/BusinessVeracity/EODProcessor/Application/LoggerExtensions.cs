using Statline.StatTrac.BusinessVeracity.Common.Domain;

namespace Statline.StatTrac.BusinessVeracity.EodProcessor.Application
{
    internal static class LoggerExtensions
    {
        public static void LogFailedToResolveContact(
            this ILogger logger,
            Exception ex,
            ReferralDetails referral, 
            ReferralLogEvent logEvent)
        {
            logger.LogWarning(
                "Failed to resolve contact for log event " +
                "'{LogEventId}' of referral '{ReferralId}': {ErrorMessage}",
                logEvent.LogEventId, referral.ReferralId, ex.Message);
        }
    }
}