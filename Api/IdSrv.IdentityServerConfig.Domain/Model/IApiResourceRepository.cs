using System.Collections.Generic;
using System.Threading.Tasks;
using IdentityServer4.EntityFramework.Entities;

namespace Statline.IdentityServer.IdentityServerConfig.Domain.Model
{
    public interface IApiResourceRepository
    {
        Task<IEnumerable<ApiResource>> ListApiResourcesAsync();
        Task<ApiResource> FindByIdAsync(int id);
        void AddApiResource(ApiResource apiResource);
        void DeleteApiResource(int id);

        // TODO: Move to another interface.
        Task SaveChangesAsync();
    }
}
