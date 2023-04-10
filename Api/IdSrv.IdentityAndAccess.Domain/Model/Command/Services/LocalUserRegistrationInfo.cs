using Statline.Common.Utilities;

namespace Statline.IdentityServer.IdentityAndAccess.Domain.Model.Command.Services
{
    public class LocalUserRegistrationInfo : UserRegistrationInfo
    {
        public string Password { get; }

        public LocalUserRegistrationInfo(
            string userName, 
            string password, 
            string email, 
            string firstName, 
            string lastName) 
            : base(userName, email, firstName, lastName)
        {
            Check.NotEmpty(password, nameof(password));
            Password = password;
        }
    }
}
