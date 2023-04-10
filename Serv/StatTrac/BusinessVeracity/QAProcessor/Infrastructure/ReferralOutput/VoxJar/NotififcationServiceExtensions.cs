using Statline.Common.Notification;

namespace Statline.StatTrac.BusinessVeracity.QAProcessor.Infrastructure.ReferralOutput.VoxJar;

internal static class NotififcationServiceExtensions
{
    public static async Task NotifyFailedUploadingToVoxJarAsync(
        this INotificationService notificationService,
        int referralId,
        int callId,
        Exception exception)
    {
        var message =
            $"An error occurred while uploading referral details to VoxJar, " +
            $"referral id = {referralId}, " +
            $"call id = {callId}. Error details:{Environment.NewLine}{exception}";

        var notificationMessage = new NotificationMessage(
            toAddress: null,
            ccAddress: null,
            content: new StringNotificationContent(message, isHtml: false),
            subject: null);

        await notificationService.SendAsync(notificationMessage).ConfigureAwait(false);
    }
}
