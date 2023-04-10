using Statline.StatTracUploader.App.Uploader;
using Statline.StatTracUploader.Domain.Common;
using System;

namespace Statline.StatTracUploader.WebUI.Models
{
    public class UploadedReferralModel
    {
        public string? SourceFileName { get; set; }
        public DateTimeOffset AddedToSystemOn { get; set; }
        public int? ReferralNumber { get; set; }
        public string CallerSourceCode { get; set; } = default!;
        public DateTimeOffset CallReceivedOn { get; set; }
        public PersonName? DonorName { get; set; }
        public DateTimeOffset? DonorDateOfBirth { get; set; }
        public ReferralProcessingStatusInfo ProcessingStatus { get; set; } = default!;
        public int? ReferralId { get; set; }
        public int? CallId { get; set; }
    }
}
