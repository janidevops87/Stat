using Statline.Common.Utilities;

namespace Statline.IdentityServer.IdentityServerConfig.App.Resources.Identity.Dto
{
    public class IdentityResourcePropertiesInfo
    {
        public IdentityResourcePropertiesInfo(
            string name,
            string displayName)
        {
            Check.NotEmpty(name, nameof(name));
            Check.NotEmpty(displayName, nameof(displayName));

            Name = name;
            DisplayName = displayName;
        }

        public string Name { get; }
        public string DisplayName { get; }
        public string Description { get; set; }
        public bool Required { get; set; }
        public bool Emphasize { get; set; }

    }
}
