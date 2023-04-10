using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Common;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Statline.IdentityServer.IdentityAndAccess.Domain.Model.Command
{
    public interface ITenantRepository
    {
        Task<IEnumerable<Tenant>> ListTenantsAsync();
        void AddTenant(Tenant tenant);
        void DeleteTenant(TenantId tenantId);
        Task<Tenant> FindByIdAsync(TenantId tenantId);
        Task<Tenant> FindByOrganizationNameAsync(string organizationName);
        Task<bool> ExistsWithOrganizationNameAsync(string organizationName);
        // TODO: Move to another interface.
        Task SaveChangesAsync();
    }
}
