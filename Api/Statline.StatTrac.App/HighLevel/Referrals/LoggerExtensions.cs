using Microsoft.Extensions.Logging;
using Statline.StatTrac.App.LowLevel.Referrals;
using Statline.StatTrac.Domain.Calls;
using Statline.StatTrac.Domain.Referrals;
using Statline.StatTrac.Domain.Referrals.Factory;

namespace Statline.StatTrac.App.HighLevel.Referrals;

internal static class LoggerExtensions
{
    public static void LogCheckingForDuplicates(
        this ILogger logger,
        DuplicateReferralsFilterCriteria filterCriteria)
    {
        logger.LogInformation(
            "Checking for duplicates according to criteria: " +
            "filter type: {FilterType}, " +
            "source code id: {SourceCodeId}, " +
            "medical record number: {MedicalRecordNumber}, " +
            "caller organization id: {CallerOrganizationId}",
            filterCriteria.FilterType,
            filterCriteria.SourceCodeId,
            filterCriteria.MedicalRecordNumber,
            filterCriteria.ReferralCallerOrganizationId);
    }

    public static void LogSavingReferralEntity(
        this ILogger logger, 
        Domain.Referrals.Factory.ReferralInfo newReferralInfo)
    {
        logger.LogInformation("Saving referral entity for donor '{DonorName}'.",
            newReferralInfo.DonorInformation.DonorPerson.Name);
    }

    public static void LogSavedReferralEntity(
        this ILogger logger,
        int referralId,
        Domain.Referrals.Factory.ReferralInfo newReferralInfo)
    {
        logger.LogInformation(
            "Saved referral entity with id '{ReferralId}' for donor '{DonorName}'.",
            referralId,
            newReferralInfo.DonorInformation.DonorPerson.Name);
    }

    public static void LogSavingCallEntity(
        this ILogger logger, 
        Domain.Referrals.Factory.ReferralInfo newReferralInfo)
{
        logger.LogInformation("Saving call entity for donor '{DonorName}'.",
            newReferralInfo.DonorInformation.DonorPerson.Name);
    }

    public static void LogSavedCallEntity(
        this ILogger logger,
        int callId,
        Domain.Referrals.Factory.ReferralInfo newReferralInfo)
    {
        logger.LogInformation(
            "Saved call entity with id '{CallId}' for donor '{DonorName}'.",
            callId,
            newReferralInfo.DonorInformation.DonorPerson.Name);
    }

    public static void LogCreatingCallEntity(
        this ILogger logger, 
        Domain.Referrals.Factory.ReferralInfo newReferralInfo)
    {
        logger.LogInformation("Creating call entity for donor '{DonorName}'.",
            newReferralInfo.DonorInformation.DonorPerson.Name);
    }

    public static void LogCreatingReferralEntity(
        this ILogger logger, 
        Domain.Referrals.Factory.ReferralInfo newReferralInfo)
    {
        logger.LogInformation(
            "Creating referral entity for donor '{DonorName}'.",
            newReferralInfo.DonorInformation.DonorPerson.Name);
    }

    public static void LogCreatingRegistryStatus(this ILogger logger, Call call)
    {
        logger.LogInformation("Creating registry status for call '{CallId}'.", call.CallId);
    }
}
