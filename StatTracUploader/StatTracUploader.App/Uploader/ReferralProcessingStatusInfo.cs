using Statline.StatTracUploader.Domain.Temporary;

namespace Statline.StatTracUploader.App.Uploader
{
    public record ReferralProcessingStatusInfo(
            ProcessingStatus Status,
            string? ErrorMessage = null);
}
