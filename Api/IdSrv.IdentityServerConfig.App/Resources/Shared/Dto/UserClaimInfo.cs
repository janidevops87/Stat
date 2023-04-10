using Statline.Common.Utilities;

namespace Statline.IdentityServer.IdentityServerConfig.App.Resources.Shared.Dto
{
    public class UserClaimInfo
    {
        public UserClaimInfo(string type)
        {
            Check.NotEmpty(type, nameof(type));
            
            Type = type;
        }

        public string Type { get; }
    }
}
