using Statline.Common.Notification;

namespace Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ReferralSource.StatTracApi;

internal static class NotififcationServiceExtensions
{
    public static async Task NotifyReferralNotFoundAsync(
        this INotificationService notificationService,
        int referralId)
    {
        var message =
            $"Referral with id = {referralId} wasn't found (deleted).";

        var notificationMessage = new NotificationMessage(
            toAddress: null,
            ccAddress: null,
            content: new StringNotificationContent(message, isHtml: false),
            subject: null);

        await notificationService.SendAsync(notificationMessage).ConfigureAwait(false);
    }
}
