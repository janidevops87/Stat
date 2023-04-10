using Statline.Common.Utilities;

namespace Statline.IdentityServer.IdentityAndAccess.App.Users.Dto
{
    public class RoleInfo
    {
        public RoleInfo(string name)
        {
            Check.NotEmpty(name, nameof(name));
            Name = name;
        }

        public string Name { get; }
    }
}
