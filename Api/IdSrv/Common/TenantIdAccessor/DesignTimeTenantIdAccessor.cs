using Statline.IdentityServer.IdentityServerConfig.Domain.Model;
using Statline.IdentityServer.IdentityServerConfig.Infrastructure.Persistence.Ef;

namespace Statline.IdentityServer.Common.TenantIdAccessor
{
    public class DesignTimeTenantIdAccessor : ITenantIdAccessor
    {
        public TenantId GetTenantId()
        {
            return 0;
        }
    }
}
