using Statline.Common.Utilities;
using Statline.StatTracUploader.App.Common.Notification;
using Statline.StatTracUploader.Domain.Temporary;
using System;
using System.Globalization;
using System.IO;
using System.Text;

namespace Statline.StatTracUploader.App.Processor
{
    internal class NotificationMessageBuilder
    {
        private static readonly CultureInfo UsCultureInfo = CultureInfo.GetCultureInfo("en-US");

        public NotificationMessage BuildNotificationMessage(ReferralUpload referralUpload)
        {
            Check.NotNull(referralUpload, nameof(referralUpload));

            return new NotificationMessage(
                toAddress: null,
                BuildNotificationContent(referralUpload),
                BuildNotificationSubject(referralUpload));
        }

        private static string BuildNotificationSubject(ReferralUpload referralUpload)
        {
            var subject = (referralUpload.Referral.IsUpdate, referralUpload.ProcessingStatus.Status) switch
            {
                (false, ProcessingStatus.Failure) => "Referral Failed",
                (false, ProcessingStatus.Success) => "Referral Success",
                (true, ProcessingStatus.Failure) => "Update Failed",
                (true, ProcessingStatus.Success) => "Update Success",
                _ => throw new InvalidOperationException("Unexpected processing status")
            };

            subject += " - " + referralUpload.SourceFileName;

            return subject;
        }

        private static NotificationContent BuildNotificationContent(ReferralUpload referralUpload)
        {
            var sb = new StringBuilder();

            if (referralUpload.ProcessingStatus.IsFailure)
            {
                sb.Append(referralUpload.Referral.IsUpdate ? "Update Failed: " : "Referral Failed: ");
                sb.AppendLine(referralUpload.ProcessingStatus.ErrorMessage ?? "<Unknown reason>");
            }

            sb.Append("Call Date/Time: ");
            sb.AppendLine(referralUpload.Referral.CallReceivedOn.ToString("g", UsCultureInfo));
            sb.Append("Source Code: ");
            sb.AppendLine(referralUpload.Referral.CallerSourceCode);
            sb.Append("Triage Coordinator: ");
            sb.AppendLine(referralUpload.Referral.CoordinatorName.ToString());

            if (referralUpload.Referral.IsUpdate)
            {
                sb.Append("Referral Number: ");
                sb.AppendLine(referralUpload.Referral.ReferralNumer?.ToString());
            }

            var stream = new MemoryStream(Encoding.UTF8.GetBytes(sb.ToString()));

            return new NotificationContent(
                content: new GenericStreamReference(stream),
                isHtml: false);
        }
    }
}
