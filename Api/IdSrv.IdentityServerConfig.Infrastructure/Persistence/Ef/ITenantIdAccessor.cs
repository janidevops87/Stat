using Statline.IdentityServer.IdentityServerConfig.Domain.Model;

namespace Statline.IdentityServer.IdentityServerConfig.Infrastructure.Persistence.Ef
{
    /// <summary>
    /// Provides a Tenant Id from some ambient context.
    /// </summary>
    public interface ITenantIdAccessor
    {
        TenantId GetTenantId();
    }
}