using Statline.StatTrac.BusinessVeracity.Common.Application;
using Statline.StatTrac.BusinessVeracity.Common.Application.CallInformation;
using Statline.StatTrac.BusinessVeracity.Common.Domain;
using System.Collections.Immutable;

#pragma warning disable CA2007 // Consider calling ConfigureAwait on the awaited task

namespace Statline.StatTrac.BusinessVeracity.EodProcessor.Application;

public partial class EodProcessorApplication :
    ReferralProcessorApplication<ReferralDetails, TransformedReferralDetails>
{
    public EodProcessorApplication(
        IOptions<EodProcessorApplicationOptions> options,
        ILogger<EodProcessorApplication> logger,
        IReferralSource<ReferralDetails> referralSource,
        IReferralOutput<TransformedReferralDetails> referralOutput,
        ICallInformationProvider callInformationProvider)
        : base(
            referralSource,
            referralOutput,
            callInformationProvider,
            options,
            logger)
    {
    }

    protected override IAsyncEnumerable<TransformedReferralDetails> ProcessReferralsAsync(
        IAsyncEnumerable<ReferralDetails> referrals)
    {
        return referrals.SelectMany(ProcessReferral);
    }

    private async IAsyncEnumerable<TransformedReferralDetails> ProcessReferral(ReferralDetails referral)
    {
        // Here we produce a separate transformed referral for each
        // phone call. Since we can have multiple phone calls for
        // each source referral during a period of time, each such referral
        // will have multiple copies in the output, one per phone call.
        // In other words, the relationship between source referrals and
        // output referrals is one-to-many.
        //
        var signOfCallEvents = referral.LogEvents.Where(le => le.IsSignOfCall());

        var logEventToContactMap =
            await LogEventToContactMap.CreateAsync(this, referral, signOfCallEvents);

        foreach (var logEvent in signOfCallEvents)
        {
            Logger.LogStartedProcessingReferral(referral.ReferralId, logEvent.LogEventId);

            TransformedReferralDetails transformedReferral;

            try
            {
                transformedReferral = TransformReferral(referral, logEvent, logEventToContactMap);
            }
            catch (ReferralProcessingException ex)
            {
                Logger.LogFailedToProcessReferral(ex, referral.ReferralId, logEvent.LogEventId);
                continue;
            }
            catch (Exception ex)
            {
                // General unexpected errors shouldn't be ignored as they
                // mean either a bug or a condition when further attempts to 
                // process referrals will fail (e.g. network connection problems).
                Logger.LogUnhandledExceptionWhileProcessingReferral(ex, referral.ReferralId, logEvent.LogEventId);
                throw;
            }

            Logger.LogFinishedProcessingReferral(referral.ReferralId, logEvent.LogEventId);

            yield return transformedReferral;
        }
    }

    private TransformedReferralDetails TransformReferral(
        ReferralDetails referral,
        ReferralLogEvent logEvent,
        LogEventToContactMap logEventToContactMap)
    {
        long contactId = logEventToContactMap.GetContactIdByLogEventId(logEvent.LogEventId);

        return new TransformedReferralDetails
        (
            #pragma warning disable format
            ContactId               : contactId,
            ReferralNumber          : referral.CallNumber,
            ReferralDateTime        : referral.CallDateTime?.ToString("MM/dd/yy hh:mm:ss"),
            ReferralTakenBy         : referral.StatEmployee,
            ReferralType            : referral.ReferralTypeName,
            CallerPhone             : referral.CallerPhone,
            CallerName              : referral.Caller,
            CallerOrganization      : referral.OrganizationName,
            CallerOrganizationUnit  : referral.CallerOrganizationUnit,
            PatientCauseOfDeath     : referral.CauseOfDeathName,
            PatientOnVentilator     : referral.ReferralDonorOnVentilator,
            PatientDeathDate        : referral.ReferralDonorDeathDate?.ToString("MM/dd/yy"),
            PatientDeathTime        : referral.ReferralDonorDeathTime,
            AppropriateOrganID      : referral.ReferralOrganAppropriateId,
            AppropriateBoneID       : referral.ReferralBoneAppropriateId,
            AppropriateSoftTissueID : referral.ReferralTissueAppropriateId,
            AppropriateSkinID       : referral.ReferralSkinAppropriateId,
            AppropriateValvesID     : referral.ReferralValvesAppropriateId,
            AppropriateEyesID       : referral.ReferralEyesTransAppropriateId,
            PatientHasHeartbeat     : referral.PatientHasHeartbeat,
            MedicalHistory          : referral.MedicalHistory,
            CallType                : referral.CallType,
            SourceCode              : referral.SourceCode
            #pragma warning restore format
        )
        {
            ReferralEvents =
                (from le in referral.LogEvents
                 where le.ShouldIncludeInOutput()
                 select TransformReferralLogEvent(le, logEventToContactMap))
                .ToImmutableArray()
        };
    }

    private TransformedReferralLogEvent TransformReferralLogEvent(
        ReferralLogEvent referralLogEvent,
        LogEventToContactMap logEventToContactMap)
    {
        long? contactId =
            logEventToContactMap.GetContactIdByLogEventIdOrDefault(referralLogEvent.LogEventId);

        return new TransformedReferralLogEvent
        (
            #pragma warning disable format
            ContactId:                      contactId,
            ReferralEventTypeID :           (int?)referralLogEvent.LogEventTypeId,
            ReferralEventType :             referralLogEvent.LogEventTypeName,
            ReferralEventDateTime :         referralLogEvent.LogEventDateTime?.ToString("MM/dd/yy hh:mm:ss"),
            ReferralEventPhone :            referralLogEvent.LogEventPhone,
            ReferralEventOrganizationID :   referralLogEvent.OrganizationId,
            ReferralEventOrganization :     referralLogEvent.LogEventOrg,
            ReferralEventCreatedBy :        referralLogEvent.LogEventCreatedBy
            #pragma warning restore format
        );
    }
}

