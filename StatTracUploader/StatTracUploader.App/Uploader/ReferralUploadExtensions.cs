using Statline.StatTracUploader.Domain.Temporary;

namespace Statline.StatTracUploader.App.Uploader
{
    internal static class ReferralUploadExtensions
    {
        public static UploadedReferralInfo ToUploadedReferralInfo(this ReferralUpload referralUpload)
        {
            var referral = referralUpload.Referral;

            return new UploadedReferralInfo(
                referralUpload.SourceFileName,
                referralUpload.AddedToSystemOn,
                referral.ReferralNumer,
                referral.CallerSourceCode,
                referral.CallReceivedOn,
                referral.DonorPerson.Name,
                referral.DonorPerson.DateOfBirth,
                new ReferralProcessingStatusInfo(
                    referralUpload.ProcessingStatus.Status,
                    referralUpload.ProcessingStatus.ErrorMessage),
                referral.Id,
                referral.CallId);
        }
    }
}
