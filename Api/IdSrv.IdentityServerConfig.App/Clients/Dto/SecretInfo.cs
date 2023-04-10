using Statline.Common.Utilities;
using System;

namespace Statline.IdentityServer.IdentityServerConfig.App.Clients.Dto
{
    public class SecretInfo
    {
        public string Type { get; }
        public string Value { get; }
        public DateTimeOffset CreationTime { get; }

        public SecretInfo(
            string type, 
            string value,
            DateTimeOffset creationTime)
        {
            Check.NotEmpty(type, nameof(type));
            Check.NotEmpty(value, nameof(value));

            Type = type;
            Value = value;
            CreationTime = creationTime;
        }
    }
}
