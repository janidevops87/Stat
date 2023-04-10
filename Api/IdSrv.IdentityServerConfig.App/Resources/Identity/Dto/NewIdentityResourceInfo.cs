using Statline.Common.Utilities;

namespace Statline.IdentityServer.IdentityServerConfig.App.Resources.Identity.Dto
{
    public class NewIdentityResourceInfo
    {
        public string DisplayName { get; }
        public string Name { get; }

        public NewIdentityResourceInfo(
            string name,
            string displayName)
        {
            Check.NotEmpty(name, nameof(name));
            Check.NotEmpty(displayName, nameof(displayName));

            Name = name;
            DisplayName = displayName;
        }
    }
}