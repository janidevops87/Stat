using Statline.Common.Utilities;

namespace Statline.IdentityServer.IdentityServerConfig.App.Clients.Dto
{
    public class ClaimInfo
    {
        public ClaimInfo(string type, string value)
        {
            Check.NotEmpty(type, nameof(type));
            Check.NotEmpty(value, nameof(value));

            Type = type;
            Value = value;
        }

        public string Type { get; }
        public string Value { get; }
    }
}
