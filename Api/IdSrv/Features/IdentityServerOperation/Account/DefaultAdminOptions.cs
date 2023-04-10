using System.Collections.Generic;

namespace Statline.IdentityServer.Features.IdentityServerOperation.Account
{
    public class DefaultAdminOptions
    {
        public string UserName { get; set; }
        public IList<string> AllowedIPs { get; set; } = new List<string>();
    }
}
