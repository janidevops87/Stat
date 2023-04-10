using Statline.Common.Utilities;

namespace Statline.IdentityServer.IdentityServerConfig.App.Clients.Dto
{
    public class NewSecretInfo
    {
        public NewSecretInfo(string type, string value)
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
