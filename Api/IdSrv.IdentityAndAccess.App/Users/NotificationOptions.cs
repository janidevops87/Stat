using Statline.Common.Utilities;

namespace Statline.IdentityServer.IdentityAndAccess.App.Users
{
    public class NotificationOptions
    {
        public string Message { get; set; }
        public string Subject { get; set; }

        public void Validate(string referencingPath)
        {
            Check.NotEmpty(referencingPath, nameof(referencingPath));
            Check.NotEmpty(Message, referencingPath + "." + nameof(Message));
            Check.NotEmpty(Subject, referencingPath + "." + nameof(Subject));
        }
    }
}
