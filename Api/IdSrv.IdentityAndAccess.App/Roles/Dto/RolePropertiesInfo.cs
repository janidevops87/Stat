using Statline.Common.Utilities;

namespace Statline.IdentityServer.IdentityAndAccess.App.Roles.Dto
{
    public class RolePropertiesInfo
    {
        public string Name { get; }

        public RolePropertiesInfo(
            string name)
        {
            Check.NotEmpty(name, nameof(name));
            Name = name;
        }
    }
}