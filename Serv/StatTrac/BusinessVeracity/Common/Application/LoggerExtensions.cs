using Statline.StatTrac.BusinessVeracity.Common.Application.CallInformation;
using System.Globalization;

namespace Statline.StatTrac.BusinessVeracity.Common.Application;

public static class LoggerExtensions
{
    internal static void LogProcessingTimeRange(
        this ILogger logger,
        DateTimeOffset startDateTime,
        DateTimeOffset endDateTime)
    {
        logger.LogInformation(
            "Running application for time range [{StartDateTime}, {EndDateTime}]",
            startDateTime,
            endDateTime);
    }

    internal static void LogChosenFile(
        this ILogger logger,
        string filePath,
        int fileLength)
    {
        logger.LogInformation(
            "Chosen file is '{FilePath}' with length {FileLength} chars (base64-encoded).",
            filePath,
            fileLength);
    }

    internal static void LogMultipleMasterContacts(
        this ILogger logger,
        IEnumerable<IGrouping<long, ContactInfo>> contactsByMasterContactId,
        Agent agent,
        DateTimeOffset callStart,
        DateTimeOffset callEnd,
        int referralId)
    {
        logger.LogWarning(
            "Found contacts with multiple master contacts [{MasterContacts}] " +
            "for agent id {AgentId} and time range '{CallStart} - {CallEnd}', " +
            "referral id {ReferralId}.",
            string.Join(", ", contactsByMasterContactId.Select(g => g.Key)),
            agent.AgentId,
            callStart.ToString(CultureInfo.InvariantCulture),
            callEnd.ToString(CultureInfo.InvariantCulture),
            referralId);
    }

    internal static void LogDownloadingAudioFiles(
       this ILogger logger,
       long contactId,
       int filesCount)
    {
        logger.LogInformation("Downloading {FilesCount} audio file(s) for contact id {ContactId}.",
            filesCount,
            contactId);
    }

    internal static void LogFoundMultipleAgentsWithSameName(
        this ILogger logger,
        string agentName)
    {
        logger.LogWarning("Found multiple agents with name '{AgentName}'.", agentName);
    }

    public static void LogStartedProcessingReferral(
        this ILogger logger,
        int referralId,
        int logEventId)
    {
        logger.LogInformation("Processing referral with id '{ReferralId}' " +
            "for log event id '{LogEventId}'.", referralId, logEventId);
    }

    public static void LogFinishedProcessingReferral(
        this ILogger logger,
        int referralId, 
        int logEventId)
    {
        logger.LogInformation("Finished processing referral with id '{ReferralId}' " +
            "for log event id '{LogEventId}'.", 
            referralId, 
            logEventId);
    }

    internal static void LogFinishedReferralsProcessing(
       this ILogger logger,
       int sourceReferralsCount,
       int outputReferralsCount)
    {
        logger.LogInformation(
            "Finished processing {SourceReferralsCount} source referrals. " +
            "Produced {OutputReferralsCount} referrals to output.", 
            sourceReferralsCount, 
            outputReferralsCount);
    }

    public static void LogFailedToProcessReferral(
        this ILogger logger,
        Exception exception,
        int referralId,
        int logEventId)
    {
        logger.LogError(exception, 
            "Failed to process source referral with id '{ReferralId}' " +
            "for log event id '{LogEventId}'.", referralId, logEventId);
    }

    public static void LogUnhandledExceptionWhileProcessingReferral(
      this ILogger logger,
      Exception exception,
      int referralId,
      int logEventId)
    {
        logger.LogCritical(
            exception,
            "Unhandled exception while processing source referral with id '{ReferralId}' " +
            "for log event id '{LogEventId}'.",
            referralId,
            logEventId);
    }

}
