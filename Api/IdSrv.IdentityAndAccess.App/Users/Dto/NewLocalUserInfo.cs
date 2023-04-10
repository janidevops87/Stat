using Statline.Common.Utilities;

namespace Statline.IdentityServer.IdentityAndAccess.App.Users.Dto
{
    public class NewLocalUserInfo
    {
        public string UserName { get; }
        public string Password { get; }
        public string Email { get; }
        public string FirstName { get; }
        public string LastName { get; }

        public NewLocalUserInfo(
            string userName,
            string password,
            string email,
            string firstName,
            string lastName)
        {
            Check.NotEmpty(userName, nameof(userName));
            Check.NotEmpty(password, nameof(password));
            Check.NotEmpty(email, nameof(email));

            UserName = userName;
            Password = password;
            Email = email;
            FirstName = firstName;
            LastName = lastName;
        }
    }
}
