using System.Threading.Tasks;

namespace Statline.IdentityServer.IdentityAndAccess.App.Common
{
    public interface INotificationService
    {
        Task SendNotificationAsync(string toAddress, string message, string subject);
    }
}
