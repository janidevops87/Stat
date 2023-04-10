using Microsoft.Extensions.Logging;
using Statline.StatTrac.Api.Client.Dto.Referrals.NewReferral;

namespace Statline.StatTrac.Integration.App.Copernicus;

internal static class LoggerExtensions
{
    public static void LogAddedNewNoteLogEvent(
        this ILogger logger,
        CreatedReferral createdReferral, 
        int createdLogEventId)
    {
        logger.LogInformation(
            "Added new note log event with id {LogEventId} for referral with id {ReferralCallId}.",
            createdLogEventId,
            createdReferral.CallId);
    }

    public static void LogAddingNewNoteLogEvent(
        this ILogger logger,
        CreatedReferral createdReferral)
    {
        logger.LogInformation(
            "Adding new note log event for referral with id {ReferralCallId}.",
            createdReferral.CallId);
    }

    public static void LogAddedNewReferral(
        this ILogger logger,
        NewReferralInfo referralInfo,
        CreatedReferral createdReferral)
    {
        logger.LogInformation(
            "Added new referral with id {ReferralCallId} for donor '{ReferralDonorName}'.",
            createdReferral.CallId,
            referralInfo.LegalFirstName + " " + referralInfo.LegalLastName);
    }

    public static void LogAddingNewReferral(
        this ILogger logger, 
        NewReferralInfo referralInfo)
    {
        logger.LogInformation(
            "Adding new referral for donor '{ReferralDonorName}'.",
            referralInfo.LegalFirstName + " " + referralInfo.LegalLastName);
    }

    public static void LogAddingPhoneNumber(
        this ILogger logger, 
        NewReferralInfo referralInfo)
    {
        logger.LogInformation(
            "Phone number '{CallerPeronName}' didn't exist in referral facility {ReferralFacilityId}, adding the phone number.",
            referralInfo.CallbackPhoneNumber,
            referralInfo.ReferralFacility);
    }

    public static void LogCheckingPhoneNumberExists(
        this ILogger logger, 
        NewReferralInfo referralInfo)
    {
        logger.LogInformation(
            "Checking if phone number '{CallbackPhoneNumber}' exists in referral facility {ReferralFacilityId}.",
            referralInfo.CallbackPhoneNumber,
            referralInfo.ReferralFacility);
    }


    public static void LogAddingCallerPerson(
        this ILogger logger, 
        NewReferralInfo referralInfo)
    {
        logger.LogInformation(
            "Caller person with name '{CallerPeronName}' didn't exist in referral facility {ReferralFacilityId}, adding the person.",
            referralInfo.ContactFirstName + " " + referralInfo.ContactLastName,
            referralInfo.ReferralFacility);
    }

    public static void LogCheckingCallerPersonExists(
        this ILogger logger, 
        NewReferralInfo referralInfo)
    {
        logger.LogInformation(
            "Checking if caller person with name '{CallerPeronName}' exists in referral facility {ReferralFacilityId}.",
            referralInfo.ContactFirstName + " " + referralInfo.ContactLastName,
            referralInfo.ReferralFacility);
    }
}
