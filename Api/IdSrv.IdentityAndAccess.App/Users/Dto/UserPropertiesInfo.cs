using Statline.Common.Utilities;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model;

namespace Statline.IdentityServer.IdentityAndAccess.App.Users.Dto
{
    public class UserPropertiesInfo
    {
        public string UserName { get; }
        public string Email { get; }

        public UserPropertiesInfo(
            string userName,
            string email)
        {
            Check.NotEmpty(userName, nameof(userName));
            Check.NotEmpty(email, nameof(email));
            UserName = userName;
            Email = email;
        }
    }
}