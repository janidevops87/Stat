using Statline.Common.Utilities;

namespace Statline.IdentityServer.IdentityAndAccess.App.Roles.Dto
{
    public class NewRoleInfo
    {
        public string Name { get; }

        public NewRoleInfo(string name)
        {
            Check.NotEmpty(name, nameof(name));
            Name = name;
        }
    }
}
