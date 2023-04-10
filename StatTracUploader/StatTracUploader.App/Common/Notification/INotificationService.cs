using System.Threading.Tasks;

namespace Statline.StatTracUploader.App.Common.Notification
{
    public interface INotificationService
    {
        Task SendAsync(NotificationMessage notification);
    }
}
