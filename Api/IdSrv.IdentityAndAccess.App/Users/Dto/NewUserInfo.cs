using Statline.Common.Utilities;

namespace Statline.IdentityServer.IdentityAndAccess.App.Users.Dto
{
    public class NewUserInfo
    {
        public string UserName { get; }
        public string Email { get; }
        public string FirstName { get; }
        public string LastName { get; }

        public NewUserInfo(
            string userName,
            string email,
            string firstName,
            string lastName)
        {
            Check.NotEmpty(userName, nameof(userName));
            Check.NotEmpty(email, nameof(email));

            UserName = userName;
            Email = email;
            FirstName = firstName;
            LastName = lastName;
        }
    }
}
