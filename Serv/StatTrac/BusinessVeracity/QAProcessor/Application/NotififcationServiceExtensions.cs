using Statline.Common.Notification;

namespace Statline.StatTrac.BusinessVeracity.QAProcessor.Application;

internal static class NotififcationServiceExtensions
{
    public static async Task NotifyRecordingNotFoundAsync(
        this INotificationService notificationService,
        long contactId,
        int referralId,
        int callId)
    {
        var message =
            $"Recording file wasn't found for contact id = {contactId}, " +
            $"referral id = {referralId}, " +
            $"call id = {callId}";

        var notificationMessage = new NotificationMessage(
            toAddress: null,
            ccAddress: null,
            content: new StringNotificationContent(message, isHtml: false),
            subject: null);

        await notificationService.SendAsync(notificationMessage).ConfigureAwait(false);
    }
}
