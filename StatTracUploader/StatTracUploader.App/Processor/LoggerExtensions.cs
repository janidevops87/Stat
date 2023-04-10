using Microsoft.Extensions.Logging;
using Statline.StatTracUploader.Domain.Temporary;
using System;

namespace Statline.StatTracUploader.App.Processor
{
    internal static class LoggerExtensions
    {
        public static void LogUnexpectedReferralRepositoryError(
            this ILogger logger, 
            ReferralUpload referralUpload, 
            Exception ex)
        {
            // We want to bring attention of admins to unexpected types of errors,
            // so log as Error.
            logger.LogError(ex,
                "Unexpected error while processing referral upload with id {ReferralUploadId}: {ErrorMessage}': ", 
                referralUpload.Id, 
                ex.Message);
        }

        public static void LogReferralProcessingError(
            this ILogger logger,
            ReferralUpload referralUpload, 
            Exception ex)
        {
            // This is an expected error which user can fix. Thus log just as warning.
            logger.LogWarning(ex,
                "Could not process referral upload with id {ReferralUploadId}: {ErrorMessage}", 
                referralUpload.Id, 
                ex.Message);
        }

    }
}
