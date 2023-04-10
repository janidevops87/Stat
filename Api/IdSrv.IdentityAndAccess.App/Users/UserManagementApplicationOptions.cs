using Statline.Common.Utilities;

namespace Statline.IdentityServer.IdentityAndAccess.App.Users
{
    public class UserManagementApplicationOptions
    {
        public NotificationOptions UserActivatedNotification { get; set; }

        public void Validate(string referencingPath)
        {
            Check.NotEmpty(referencingPath, nameof(referencingPath));

            // TODO: Think how to automate this.
            var userActivatedNotificatioReferencingPath =
                referencingPath + "." + nameof(UserActivatedNotification);

            Check.NotNull(
                UserActivatedNotification,
                userActivatedNotificatioReferencingPath);

            UserActivatedNotification.Validate(userActivatedNotificatioReferencingPath);
        }
    }
}
