using System.Collections.Generic;
using System.Threading.Tasks;
using IdentityServer4.EntityFramework.Entities;
using Microsoft.EntityFrameworkCore;
using Statline.Common.Infrastructure.Domain.Repository;
using Statline.Common.Utilities;
using Statline.IdentityServer.IdentityServerConfig.Domain.Model;

namespace Statline.IdentityServer.IdentityServerConfig.Infrastructure.Persistence.Ef
{
    public class EfIdentityResourceRepository :
        RepositoryBase<MultiTenantConfigurationDbContext>,
        IIdentityResourceRepository
    {
        public EfIdentityResourceRepository(MultiTenantConfigurationDbContext configurationDbContext)
            : base(configurationDbContext)
        {
        }

        public void AddIdentityResource(IdentityResource identityResource)
        {
            Check.NotNull(identityResource, nameof(identityResource));

            DbContext.IdentityResources.Add(identityResource);
        }

        // TODO: Consider only marking deleted 
        // (but remember there will be implicit IdentityResource ID conflict
        // with existing but "invisible" entities on equal IdentityResource IDs).
        public void DeleteIdentityResource(int id)
        {
            Check.BiggerOrEqual(id, other: 0, nameof(id));

            // Using the approach with attaching entity, look here
            // https://docs.microsoft.com/en-us/aspnet/core/data/ef-mvc/crud#update-the-delete-page.
            var identityResourceToDelete = new IdentityResource { Id = id };
            DbContext.Entry(identityResourceToDelete).State = EntityState.Deleted;
        }

        public async Task<IEnumerable<IdentityResource>> ListIdentityResourcesAsync()
        {
            var identityResources = await DbContext.IdentityResources
                .ToArrayAsync()
                .ConfigureAwait(false);

            return identityResources;
        }

        public async Task<IdentityResource> FindByIdAsync(int id)
        {
            Check.BiggerOrEqual(id, other: 0, nameof(id));

            var identityResource = await DbContext.IdentityResources
                .Include(x => x.UserClaims)
                .FirstOrDefaultAsync(x => x.Id == id)
                .ConfigureAwait(false);

            return identityResource;
        }
    }
}
