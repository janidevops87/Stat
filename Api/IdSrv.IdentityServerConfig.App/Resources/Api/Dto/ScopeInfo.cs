using Statline.Common.Utilities;

namespace Statline.IdentityServer.IdentityServerConfig.App.Resources.Api.Dto
{
    public class ScopeInfo
    {
        public ScopeInfo(string name, string displayName)
        {
            Check.NotEmpty(name, nameof(name));
            Check.NotEmpty(displayName, nameof(displayName));

            Name = name;
            DisplayName = displayName;
        }

        public string Name { get; }
        public string DisplayName { get; }
    }
}
