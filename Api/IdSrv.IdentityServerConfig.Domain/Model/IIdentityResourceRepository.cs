using System.Collections.Generic;
using System.Threading.Tasks;
using IdentityServer4.EntityFramework.Entities;

namespace Statline.IdentityServer.IdentityServerConfig.Domain.Model
{
    public interface IIdentityResourceRepository
    {
        Task<IEnumerable<IdentityResource>> ListIdentityResourcesAsync();
        Task<IdentityResource> FindByIdAsync(int id);
        void AddIdentityResource(IdentityResource IdentityResource);
        void DeleteIdentityResource(int id);
        
        // TODO: Move to another interface.
        Task SaveChangesAsync();
    }
}
