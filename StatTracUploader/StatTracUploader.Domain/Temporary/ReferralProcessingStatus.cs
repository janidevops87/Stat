using Statline.Common.Utilities;

namespace Statline.StatTracUploader.Domain.Temporary
{
    public record ReferralProcessingStatus
    {
        public ProcessingStatus Status { get; }
        public string? ErrorMessage { get; }
        public bool IsSuccess => Status == ProcessingStatus.Success;
        public bool IsFailure => Status == ProcessingStatus.Failure;

        public ReferralProcessingStatus(
            ProcessingStatus status,
            string? errorMessage = null)
        {
            Status = status;

            if (IsFailure)
            {
                ErrorMessage = Check.NotEmpty(errorMessage, nameof(errorMessage));
            }
        }

        public static ReferralProcessingStatus Failure(string errorMessage)
        {
            return new ReferralProcessingStatus(ProcessingStatus.Failure, errorMessage);
        }

        public static ReferralProcessingStatus Pending()
        {
            return new ReferralProcessingStatus(ProcessingStatus.Pending);
        }

        public static ReferralProcessingStatus Success()
        {
            return new ReferralProcessingStatus(ProcessingStatus.Success);
        }
    }
}
