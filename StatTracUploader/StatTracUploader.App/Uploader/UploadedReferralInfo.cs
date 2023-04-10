using Statline.StatTracUploader.Domain.Common;
using Statline.StatTracUploader.Domain.Temporary;
using System;

namespace Statline.StatTracUploader.App.Uploader
{
    public record UploadedReferralInfo(
            string? SourceFileName, 
            DateTimeOffset AddedToSystemOn,
            int? ReferralNumber,
            string CallerSourceCode,
            DateTimeOffset CallReceivedOn,
            PersonName? DonorName,
            DateTimeOffset? DonorDateOfBirth,
            ReferralProcessingStatusInfo ProcessingStatus,
            int? ReferralId,
            int? CallId);
    
}