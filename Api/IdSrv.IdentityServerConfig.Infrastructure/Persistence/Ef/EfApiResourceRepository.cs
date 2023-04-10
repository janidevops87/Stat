using System.Collections.Generic;
using System.Threading.Tasks;
using IdentityServer4.EntityFramework.Entities;
using Microsoft.EntityFrameworkCore;
using Statline.Common.Infrastructure.Domain.Repository;
using Statline.Common.Utilities;
using Statline.IdentityServer.IdentityServerConfig.Domain.Model;

namespace Statline.IdentityServer.IdentityServerConfig.Infrastructure.Persistence.Ef
{
    public class EfApiResourceRepository :
        RepositoryBase<MultiTenantConfigurationDbContext>,
        IApiResourceRepository
    {
        public EfApiResourceRepository(MultiTenantConfigurationDbContext configurationDbContext)
            :base(configurationDbContext)
        {
        }

        public void AddApiResource(ApiResource apiResource)
        {
            Check.NotNull(apiResource, nameof(apiResource));

            DbContext.ApiResources.Add(apiResource);
        }

        // TODO: Consider only marking deleted 
        // (but remember there will be implicit ApiResource ID conflict
        // with existing but "invisible" entities on equal ApiResource IDs).
        public void DeleteApiResource(int id)
        {
            Check.BiggerOrEqual(id, other: 0, nameof(id));

            // Using the approach with attaching entity, look here
            // https://docs.microsoft.com/en-us/aspnet/core/data/ef-mvc/crud#update-the-delete-page.
            var apiResourceToDelete = new ApiResource { Id = id };
            DbContext.Entry(apiResourceToDelete).State = EntityState.Deleted;
        }

        public async Task<IEnumerable<ApiResource>> ListApiResourcesAsync()
        {
            var apiResources = await DbContext.ApiResources
                .ToArrayAsync()
                .ConfigureAwait(false);

            return apiResources;
        }

        public async Task<ApiResource> FindByIdAsync(int id)
        {
            Check.BiggerOrEqual(id, other: 0, nameof(id));

            var apiResource = await DbContext.ApiResources
                .Include(x => x.Scopes)
                .Include(x => x.UserClaims)
                .FirstOrDefaultAsync(x => x.Id == id)
                .ConfigureAwait(false);

            return apiResource;
        }
    }
}
