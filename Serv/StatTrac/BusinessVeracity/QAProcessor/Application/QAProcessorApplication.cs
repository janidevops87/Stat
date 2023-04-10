using Statline.Common.Notification;
using Statline.StatTrac.BusinessVeracity.Common.Application;
using Statline.StatTrac.BusinessVeracity.Common.Application.CallInformation;
using Statline.StatTrac.BusinessVeracity.QAProcessor.Domain;


namespace Statline.StatTrac.BusinessVeracity.QAProcessor.Application;

#pragma warning disable CA2007 // Consider calling ConfigureAwait on the awaited task

public class QAProcessorApplication :
    ReferralProcessorApplication<HighRiskReferralDetails, HighRiskReferralMetadata>
{
    private readonly INotificationService notificationService;
    private readonly QAProcessorApplicationOptions options;

    public QAProcessorApplication(
        IReferralSource<HighRiskReferralDetails> referralSource,
        IReferralOutput<HighRiskReferralMetadata> referralOutput,
        ICallInformationProvider callInformationProvider,
        IOptions<QAProcessorApplicationOptions> options,
        ILogger<QAProcessorApplication> logger,
        INotificationService notificationService) :
        base(
            referralSource,
            referralOutput,
            callInformationProvider,
            options,
            logger)
    {

        this.options = Check.NotNull(options, nameof(options)).Value;
        this.notificationService = Check.NotNull(notificationService, nameof(notificationService));
    }

    protected override async IAsyncEnumerable<HighRiskReferralMetadata> ProcessReferralsAsync(
        IAsyncEnumerable<HighRiskReferralDetails> referrals)
    {
        await foreach (var referral in referrals)
        {
            Logger.LogStartedProcessingReferral(referral.ReferralId, referral.HighRiskLogEventId);

            HighRiskReferralMetadata referralMetadata;

            try
            {
                referralMetadata = await ProcessReferralAsync(referral);
            }
            catch (ReferralProcessingException ex)
            {
                Logger.LogFailedToProcessReferral(ex, referral.ReferralId, referral.HighRiskLogEventId);
                continue;
            }
            catch (Exception ex)
            {
                // General unexpected errors shouldn't be ignored as they
                // mean either a bug or a condition when further attempts to 
                // process referrals will fail (e.g. network connection problems).
                Logger.LogUnhandledExceptionWhileProcessingReferral(ex, referral.ReferralId, referral.HighRiskLogEventId);
                throw;
            }

            Logger.LogFinishedProcessingReferral(referral.ReferralId, referral.HighRiskLogEventId);

            yield return referralMetadata;
        }
    }

    private async ValueTask<HighRiskReferralMetadata> ProcessReferralAsync(HighRiskReferralDetails referral)
    {
        var highRiskLogEvent = referral.GetLogEventById(referral.HighRiskLogEventId);

        var callTimings = GetCallTimingsFromLogEvent(referral, highRiskLogEvent);

        var agent = await FindAgentAsync(highRiskLogEvent.LogEventCreatedBy, referral.ReferralId);

        var contact = await GetMasterContactAsync(agent, callTimings, referral.ReferralId);

        var audioFile = await GetContactAudioFileAsync(contact.ContactId);

        if (audioFile is null)
        {
            await notificationService.NotifyRecordingNotFoundAsync(
                contact.ContactId,
                referral.ReferralId,
                referral.CallId);

            throw new ReferralProcessingException(
                $"Recording file wasn't found for contact id = {contact.ContactId}.", referral.ReferralId);
        }

        var contactPrimaryDispositionName =
            (await GetDispositionByIdAsync(contact.PrimaryDispositionId))?.DispositionName;

        var contactSecondaryDispositionName =
            (await GetDispositionByIdAsync(contact.SecondaryDispositionId))?.DispositionName;

        return new HighRiskReferralMetadata(
            referral,
            highRiskLogEvent,
            contact,
            contactPrimaryDispositionName,
            contactSecondaryDispositionName,
            agent,
            audioFile.Value.Data,
            audioFile.Value.Path);
    }

    private async Task<Disposition?> GetDispositionByIdAsync(int? dispositionId)
    {
        // It turns out disposition id can sometimes be 0,
        // and such id is non-existing in the same way as null.
        return dispositionId is null or 0 ?
            null :
            await CallInformationProvider.FindDispositionByIdAsync(dispositionId.Value);
    }
}
