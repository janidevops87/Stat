using Statline.Common.Utilities;

namespace Statline.IdentityServer.IdentityServerConfig.App.Clients.Dto
{
    public class ScopeInfo
    {
        public ScopeInfo(string name)
        {
            Check.NotEmpty(name, nameof(name));
            Name = name;
        }

        public string Name { get; }
    }
}
