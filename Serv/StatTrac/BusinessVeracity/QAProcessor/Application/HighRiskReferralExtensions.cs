using Statline.StatTrac.BusinessVeracity.Common.Application;
using Statline.StatTrac.BusinessVeracity.Common.Domain;
using Statline.StatTrac.BusinessVeracity.QAProcessor.Domain;

namespace Statline.StatTrac.BusinessVeracity.QAProcessor.Application;

internal static class HighRiskReferralExtensions
{
    public static ReferralLogEvent GetLogEventById(this HighRiskReferralDetails referral, int logEventId)
    {
        var logEvent = referral.LogEvents.FirstOrDefault(le => le.LogEventId == logEventId);

        if (logEvent is null)
        {
            throw new ReferralProcessingException(
                $"Referral log event with id '{logEventId}' wasn't found.", referral.ReferralId);
        }

        return logEvent;
    }
}
