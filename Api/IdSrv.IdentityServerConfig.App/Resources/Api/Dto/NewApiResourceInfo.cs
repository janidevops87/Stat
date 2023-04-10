using Statline.Common.Utilities;

namespace Statline.IdentityServer.IdentityServerConfig.App.Resources.Api.Dto
{
    public class NewApiResourceInfo
    {
        public string DisplayName { get; }
        public string Name { get; }

        public NewApiResourceInfo(
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