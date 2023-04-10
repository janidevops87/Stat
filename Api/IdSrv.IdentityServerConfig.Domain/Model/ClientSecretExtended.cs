using IdentityServer4.EntityFramework.Entities;
using System;

namespace Statline.IdentityServer.IdentityServerConfig.Domain.Model
{
    public class ClientSecretExtended : ClientSecret
    {
        public DateTimeOffset CreationTime { get; set; }
    }
}
