using Statline.StatTrac.BusinessVeracity.Common.Application.CallInformation;
using Statline.StatTrac.BusinessVeracity.Common.Domain;
using System.Globalization;

namespace Statline.StatTrac.BusinessVeracity.Common.Application;

#pragma warning disable CA2007 // Consider calling ConfigureAwait on the awaited task

public abstract class ReferralProcessorApplication<TInReferral, TOutReferral> : IReferralProcessorApplication where TInReferral : ReferralDetails
{
    private readonly ReferralProcessorApplicationOptions options;
    private readonly CallCalculationsService callCalculationsService;
    private readonly IReferralSource<TInReferral> referralSource;
    private readonly IReferralOutput<TOutReferral> referralOutput;

    protected ILogger Logger { get; }
    protected ICallInformationProvider CallInformationProvider { get; }

    protected ReferralProcessorApplication(
        IReferralSource<TInReferral> referralSource,
        IReferralOutput<TOutReferral> referralOutput,
        ICallInformationProvider callInformationProvider,
        IOptions<ReferralProcessorApplicationOptions> options,
        ILogger<ReferralProcessorApplication<TInReferral, TOutReferral>> logger)
    {
        this.options = Check.NotNull(options, nameof(options)).Value;
        this.referralSource = Check.NotNull(referralSource, nameof(referralSource));
        this.referralOutput = Check.NotNull(referralOutput, nameof(referralOutput));

        CallInformationProvider = Check.NotNull(callInformationProvider, nameof(callInformationProvider));
        Logger = Check.NotNull(logger, nameof(logger));

        callCalculationsService = new CallCalculationsService(
            new CallCalculationsServiceOptions(
                this.options.NewReferralCallTimeMargin,
                this.options.ReferralUpdateCallTimeMargin,
                this.options.NewReferralDefaultCallDuration));
    }

    public async Task RunAsync(ApplicationRunContext runContext)
    {
        runContext = runContext with
        {
            StartDateTime = runContext.StartDateTime + options.ProcessingTimeAdjustment,
            EndDateTime = runContext.EndDateTime + options.ProcessingTimeAdjustment
        };

        Logger.LogProcessingTimeRange(runContext.StartDateTime, runContext.EndDateTime);

        int sourceReferralsCount = 0;

        var referrals = referralSource
            .GetReferralsAsync(runContext.StartDateTime, runContext.EndDateTime)
            .Do(referral => sourceReferralsCount++);

        int outputReferralsCount = 0;

        var transformedReferrals =
            ProcessReferralsAsync(referrals).
            Do(onNext: _ => outputReferralsCount++,
               onError: _ => { },
               onCompleted: () => Logger.LogFinishedReferralsProcessing(sourceReferralsCount, outputReferralsCount));

        // This is where we actually enumerate the sequence and get all errors.
        await referralOutput.PublishAsync(transformedReferrals, runContext);
    }

    protected abstract IAsyncEnumerable<TOutReferral> ProcessReferralsAsync(
        IAsyncEnumerable<TInReferral> referrals);

    protected async Task<Agent> FindAgentAsync(string agentFullName, int referralId)
    {
        var foundAgents = await CallInformationProvider.FindAgentsByFullNameAsync(agentFullName);

        if (foundAgents.Count > 1)
        {
            Logger.LogFoundMultipleAgentsWithSameName(agentFullName);
        }

        var agent = foundAgents.FirstOrDefault();

        if (agent is null)
        {
            throw new ReferralProcessingException(
                $"Agent with name '{agentFullName}' wasn't found.", referralId);
        }

        return agent;
    }

    protected async Task<Contact> GetMasterContactAsync(
        Agent agent,
        CallTimings callTimings,
        int referralId)
    {
        var (callStart, callEnd) = callTimings;

        var completedContacts = await CallInformationProvider.GetCompletedContactsAsync(
            callStart,
            callEnd,
            agent.AgentId);

        if (completedContacts.Count == 0)
        {
            throw new ReferralProcessingException(
                $"Contacts weren't found for agent id {agent.AgentId} and time range '" +
                $"{callStart.ToString(CultureInfo.InvariantCulture)} - " +
                $"{callEnd.ToString(CultureInfo.InvariantCulture)}'.",
                referralId);
        }

        // Theoretically it's possible to get multiple master contacts if
        // the time range is too wide.
        // For now, we just log such cases...
        //
        // TODO: To narrow down the number of contacts returned we can consider to additionally
        // pass ANI and area code (first 3 from refdetails.CallerPhone) to the InContact API
        // when querying for completed contacts (or do filtering on the client side here, or combination).
        var contactsByMasterContactId = completedContacts.GroupBy(c => c.MasterContactId);

        if (contactsByMasterContactId.Count() > 1)
        {
            Logger.LogMultipleMasterContacts(contactsByMasterContactId, agent, callStart, callEnd, referralId);
        }

        // ... and take the first master contact group and the first sub-contact.
        var subContact = contactsByMasterContactId.First().First();

        var masterContact = await CallInformationProvider.FindContactByIdAsync(contactId: subContact.MasterContactId);

        if (masterContact is null)
        {
            throw new ReferralProcessingException(
                $"Can't find master contact with id {subContact.MasterContactId} " +
                $"and sub-contact id {subContact.ContactId}.",
                referralId);
        }

        return masterContact;
    }

    protected async Task<(string Data, string Path)?> GetContactAudioFileAsync(long contactId)
    {
        var filesForContact = await CallInformationProvider.GetContactRecordingFilesAsync(contactId);

        if (!filesForContact.Any())
        {
            return null;
        }

        // In some (rare) cases we may have multiple (typically two) audio files
        // for one contact. Those multiple files are usually the same recordings,
        // but some of them are shorter (truncated). We need single file, and as
        // a workaround we choose the biggest one. Unfortunately, to know file length
        // it should be downloaded first. So we download all files and choose
        // the biggest.
        //
        // Note, that files are downloaded into memory, as we don't expect too
        // many files per contact.
        var tasks = filesForContact
            .Select(async filePath =>
            {
                var fileData = await CallInformationProvider.DownloadRecordingFileAsync(filePath);
                return (fileData, filePath);
            })
            .ToArray();

        Logger.LogDownloadingAudioFiles(contactId, filesCount: tasks.Length);

        var filesContents = await Task.WhenAll(tasks);

        var longestFile = filesContents
            .Aggregate((longest, next) => next.fileData.Length > longest.fileData.Length ? next : longest);

        Logger.LogChosenFile(longestFile.filePath, longestFile.fileData.Length);

        return longestFile;
    }

    protected CallTimings GetCallTimingsFromLogEvent(
        ReferralDetails referral,
        ReferralLogEvent callBoundLogEvent)
    {
        var callTimings = 
            callCalculationsService.GetCallTimingsFromLogEvent(referral, callBoundLogEvent);

        if (callTimings.CallDuration > options.MaxCallDuration)
        {
            throw new ReferralProcessingException(
                $"Calculated call duration {callTimings.CallDuration} for log event {callBoundLogEvent.LogEventId} " +
                $"is bigger than the expected maximum duration {options.MaxCallDuration}",
                referral.ReferralId);
        }

        return callTimings;
    }
}

