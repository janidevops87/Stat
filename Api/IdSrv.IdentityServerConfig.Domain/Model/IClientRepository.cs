using System.Collections.Generic;
using System.Threading.Tasks;
using IdentityServer4.EntityFramework.Entities;

namespace Statline.IdentityServer.IdentityServerConfig.Domain.Model
{
    public interface IClientRepository
    {
        Task<IEnumerable<Client>> ListClientsAsync();
        Task<Client> FindByIdAsync(int id);
        void AddClient(Client client);
        void DeleteClient(Client client);

        // TODO: Move to another interface.
        Task SaveChangesAsync();
    }
}
