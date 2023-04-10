using Statline.StatTrac.BusinessVeracity.Common.Domain;

using static Statline.StatTrac.BusinessVeracity.Common.Domain.ReferralLogEventType;

namespace Statline.StatTrac.BusinessVeracity.EodProcessor.Application
{
    internal static class ReferralLogEventExtensions
    {
        /// <summary>
        /// Checks if a log event can be treated as a sign of a call.
        /// </summary>
        /// <remarks>
        /// As a sign of phone calls we use certain types of log events
        /// specified below. We imply that during a phone call only one
        /// of this events can happen. As Lisa said, they won't normally
        /// have multiple events for the same referral, there is a slight
        /// chance we could get a call where the nurse was reporting a new referral and
        /// also updating us on the change in status in a different
        /// referral. We wont be able to capture that so we can go with
        /// one event now.
        /// </remarks>
        public static bool IsSignOfCall(this ReferralLogEvent logEvent) =>
            logEvent.LogEventTypeId is
                IncomingCall or
                OutgoingCall or
                CaseUpdate or
                ConsentOutcome or
                RecoveryOutcome;

        public static bool ShouldIncludeInOutput(this ReferralLogEvent logEvent) =>
            logEvent.LogEventTypeId is
                IncomingCall or
                OutgoingCall or
                PagePending or
                EmailPending or
                CaseUpdate or
                ConsentObtained or
                EmailSent or
                PageSent;
    }
}
