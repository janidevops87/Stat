using static Statline.StatTrac.BusinessVeracity.Common.Domain.ReferralLogEventType;

namespace Statline.StatTrac.BusinessVeracity.Common.Domain;

public class CallCalculationsService
{
    private readonly CallCalculationsServiceOptions options;

    public CallCalculationsService(
        CallCalculationsServiceOptions options)
    {
        this.options = Check.NotNull(options, nameof(options));
    }

    public CallTimings GetCallTimingsFromLogEvent(
        ReferralDetails referral,
        ReferralLogEvent callBoundLogEvent)
    {
        Check.NotNull(referral, nameof(referral));
        Check.NotNull(callBoundLogEvent, nameof(callBoundLogEvent));

        CallTimings callTimings;

        if (callBoundLogEvent.LogEventTypeId == IncomingCall)
        {
            // This is a new referral.
            callTimings = CalculateNewReferralCallTimings(referral);

            callTimings = new CallTimings(
                callTimings.CallStart.Add(options.NewReferralCallTimeMargin.CallStartMargin),
                callTimings.CallEnd.Add(options.NewReferralCallTimeMargin.CallEndMargin));
        }
        else // This is a referral update.
        {
            DateTimeOffset logEventDateTime =
                callBoundLogEvent.LogEventDateTime ??
                throw new InvalidOperationException($"Referral log event {callBoundLogEvent.LogEventId} doesn't have date/time.");

            callTimings = new CallTimings(
                logEventDateTime.Add(options.ReferralUpdateCallTimeMargin.CallStartMargin),
                logEventDateTime.Add(options.ReferralUpdateCallTimeMargin.CallEndMargin));
        }

        return callTimings;
    }

    private CallTimings CalculateNewReferralCallTimings(ReferralDetails referral)
    {
        // NOTE: this code is ported from [Api.sps_QAProcessor.GetTimeFrameVoiceCalls]
        // SQL function with maximum compatibility in mind. It can probably
        // be written better.

        var intermediateTimings =
           from le in referral.LogEvents
           let isCallStartOrEndEvent = le.LogEventTypeId is
               IncomingCall or
               OutgoingCall or
               PagePending or
               EmailPending or
               EmailSent
           where isCallStartOrEndEvent
           // We always going to have one group here.
           // Grouping is needed just for aggregation operations.
           group le by le.ReferralId into referralGroup
           select new
           {
               // We interpret IncomingCall event as a sign of phone
               // call start, and any other event - as call end.
               // Since we calculate this only for new referral call,
               // take the earliest events for both (using Min).
               CallStart = referralGroup
                   .Where(le => le.LogEventTypeId == IncomingCall)
                   .Select(le => le.LogEventDateTime)
                   .Min(),
               CallEnd = referralGroup
                   .Where(le => le.LogEventTypeId != IncomingCall)
                   .Select(le => le.LogEventDateTime)
                   .Min()
           };

        var timings =
            from t in intermediateTimings
            // Guard against cases when there is no Incoming Call event (not sure if that's possible).
            where t.CallStart is not null
            // 1. When CallEnd is not NULL AND CallEnd > CallStart: use CallEnd.
            // 2. Otherwise: use CallStart with some added margin.
            // In some rare cases it may happen that Incoming Call event comes later than
            // other events, so it's possible that CallEnd < CallStart (1).
            let callEnd = t.CallEnd > t.CallStart ? t.CallEnd : t.CallStart + options.NewReferralDefaultCallDuration
            select new CallTimings(t.CallStart!.Value, callEnd.Value);

        // We expect at least one call start-related log event for a new referral.
        // And we select the earliest one, as was described in the
        // grouping statement above.
        return timings.Single();
    }
}
