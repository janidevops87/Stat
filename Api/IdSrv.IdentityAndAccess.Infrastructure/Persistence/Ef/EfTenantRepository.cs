using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Statline.Common.Infrastructure.Domain.Repository;
using Statline.Common.Utilities;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Command;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Common;

namespace Statline.IdentityServer.IdentityAndAccess.Infrastructure.Persistence.Ef
{
    public class EfTenantRepository :
        RepositoryBase<IdentityAndAccessDbContext>,
        ITenantRepository
    {
        public EfTenantRepository(IdentityAndAccessDbContext dbContext)
            : base(dbContext)
        {
        }

        public async Task<IEnumerable<Tenant>> ListTenantsAsync()
        {
            return await DbContext
                .Tenants
                .OrderBy(t => t.OrganizationName)
                .ToArrayAsync().ConfigureAwait(false);
        }

        public void AddTenant(Tenant tenant)
        {
            Check.NotNull(tenant, nameof(tenant));
            DbContext.Tenants.Add(tenant);
        }

        public void DeleteTenant(TenantId tenantId)
        {
            Check.NotNull(tenantId, nameof(tenantId));

            // This is an approach with attaching entity.
            // https://docs.microsoft.com/en-us/aspnet/core/data/ef-mvc/crud#update-the-delete-page.
            var tenant = new Tenant(tenantId, organizationName: "NotImportant");
            DbContext.Entry(tenant).State = EntityState.Deleted;
        }

        public async Task<Tenant> FindByIdAsync(TenantId tenantId)
        {
            Check.NotNull(tenantId, nameof(tenantId));
            return await FindTenant(x => x.Id == tenantId.Value).ConfigureAwait(false);
        }

        public async Task<Tenant> FindByOrganizationNameAsync(string organizationName)
        {
            Check.NotEmpty(organizationName, nameof(organizationName));
            return await FindTenant(x => x.OrganizationName == organizationName).ConfigureAwait(false);
        }

        public async Task<bool> ExistsWithOrganizationNameAsync(string organizationName)
        {
            Check.NotEmpty(organizationName, nameof(organizationName));
            return await DbContext.Tenants.AnyAsync(t => t.OrganizationName == organizationName).ConfigureAwait(false);
        }

        private async Task<Tenant> FindTenant(Expression<Func<Tenant, bool>> predicate)
        {
            return await DbContext.Tenants
                .Include(t => t.UserClaims)
                .FirstOrDefaultAsync(predicate)
                .ConfigureAwait(false);
        }
    }
}
