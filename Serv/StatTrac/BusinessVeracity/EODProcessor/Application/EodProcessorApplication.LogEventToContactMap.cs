using Statline.StatTrac.BusinessVeracity.Common.Domain;
using System.Runtime.ExceptionServices;

namespace Statline.StatTrac.BusinessVeracity.EodProcessor.Application;

#pragma warning disable CA2007 // Consider calling ConfigureAwait on the awaited task

public partial class EodProcessorApplication
{
    /// <summary>
    /// Represents a pre-loaded map of log events to contacts.
    /// </summary>
    /// <remarks>
    /// We have a reqirement to associate each call-bound log event 
    /// of a referral to a contact id. We also map each referral to many
    /// call-bound log events it has. So this gives us a cartesian product
    /// of log events, for which we need to resolve contact ids. Obviosly,
    /// we will repeat the same lookups multiple times. This class helps to 
    /// avoid this by resolving all referral call-bound log events in advance
    /// and then providing fast lookup using an in-memory cache. It also captures
    /// any errors which occur at time of contact resolving and rethrows them
    /// at lookup attempt, giving illusion of resolving at the place of lookup 
    /// (which should make error investigation easier).
    /// </remarks>
    private class LogEventToContactMap
    {
        private record ContactResolveResult(long? ContactId, ExceptionDispatchInfo? Exception);

        private readonly IReadOnlyDictionary<int, ContactResolveResult> eventIdToContactIdMap;

        private LogEventToContactMap(
            IReadOnlyDictionary<int, ContactResolveResult> eventIdToContactIdMap)
        {
            this.eventIdToContactIdMap = eventIdToContactIdMap;
        }

        public long GetContactIdByLogEventId(int logEventId)
        {
            // We expect that lookups will always be done for
            // an event which was previosly resolved
            // (either successfully or with an error).
            // So KeyNotFoundException here will be an indication
            // of a bug in the calling code.
            var resolveResult = eventIdToContactIdMap[logEventId];

            if (resolveResult.Exception is not null)
            {
                resolveResult.Exception.Throw();
            }

            return resolveResult.ContactId!.Value;
        }

        public long? GetContactIdByLogEventIdOrDefault(int logEventId) =>
            eventIdToContactIdMap.GetValueOrDefault(logEventId)?.ContactId;

        public static async Task<LogEventToContactMap> CreateAsync(
            EodProcessorApplication application,
            ReferralDetails referral,
            IEnumerable<ReferralLogEvent> eventsOfInterest)
        {
            var map = await ResolveAndMapLogEventsToContactsAsync(application, referral, eventsOfInterest);
            return new LogEventToContactMap(map);
        }

        private static async Task<IReadOnlyDictionary<int, ContactResolveResult>>
            ResolveAndMapLogEventsToContactsAsync(
                EodProcessorApplication application,
                ReferralDetails referral,
                IEnumerable<ReferralLogEvent> logEvents)
        {
            return await logEvents
                .ToAsyncEnumerable()
                .ToDictionaryAwaitAsync(
                    logEvent => ValueTask.FromResult(logEvent.LogEventId),
                    async logEvent =>
                    {
                        long? contactId = null;
                        ExceptionDispatchInfo? exceptionInfo = null;

                        try
                        {
                            contactId = await ResolveContactIdAsync(application, referral, logEvent);
                        }
                        catch (Exception ex)
                        {
                            application.Logger.LogFailedToResolveContact(ex, referral, logEvent);

                            // Capture all errors to rethrow them at the place
                            // where contact id lookup happens. This
                            // allows to easier find connection between
                            // referral being processed and the error which
                            // prevents this.
                            exceptionInfo = ExceptionDispatchInfo.Capture(ex);
                        }

                        return new ContactResolveResult(contactId, exceptionInfo);
                    });
        }

        private static async Task<long> ResolveContactIdAsync(
            EodProcessorApplication application,
            ReferralDetails referral,
            ReferralLogEvent logEvent)
        {
            var callTimings = application.GetCallTimingsFromLogEvent(referral, logEvent);

            var agent = await application.FindAgentAsync(logEvent.LogEventCreatedBy, referral.ReferralId);

            var contact = await application.GetMasterContactAsync(agent, callTimings, referral.ReferralId);

            return contact.ContactId;
        }
    }
}

