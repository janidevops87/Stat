using System.Collections.Generic;
using System.Threading.Tasks;
using IdentityServer4.EntityFramework.Entities;
using Microsoft.EntityFrameworkCore;
using Statline.Common.Infrastructure.Domain.Repository;
using Statline.Common.Utilities;
using Statline.IdentityServer.IdentityServerConfig.Domain.Model;

namespace Statline.IdentityServer.IdentityServerConfig.Infrastructure.Persistence.Ef
{
    public class EfClientRepository :
        RepositoryBase<MultiTenantConfigurationDbContext>,
        IClientRepository
    {
        public EfClientRepository(MultiTenantConfigurationDbContext configurationDbContext)
            : base(configurationDbContext)
        {
        }

        public void AddClient(Client client)
        {
            Check.NotNull(client, nameof(client));

            DbContext.Clients.Add(client);
        }

        // TODO: Consider only marking deleted 
        // (but remember there will be implicit Client ID conflict
        // with existing but "invisible" entities on equal CLient IDs).
        public void DeleteClient(Client client)
        {
            Check.NotNull(client, nameof(client));

            // This is an approach with attaching entity.
            // https://docs.microsoft.com/en-us/aspnet/core/data/ef-mvc/crud#update-the-delete-page.
            // WARNING: This allows deleting any client regardless 
            // of tenant because global filters are not applied.
            // This is why we don't use it.
            //var client = new Client { Id = id };
            //DbContext.Entry(client).State = EntityState.Deleted;
            //
            // This issue requests to support *conditional*
            // modifications (including deletion) without
            // loading entities first: 
            // https://github.com/aspnet/EntityFrameworkCore/issues/795.
            //
            // For now we have to load an entity first if we want to filter
            // by conditions (including global filters).
            DbContext.Clients.Remove(client);
        }

        public async Task<IEnumerable<Client>> ListClientsAsync()
        {
            var clients = await DbContext.Clients
                .Include(c => c.Properties)
                .ToArrayAsync()
                .ConfigureAwait(false);

            return clients;
        }

        public async Task<Client> FindByIdAsync(int id)
        {
            CheckId(id);

            var client = await DbContext.Clients
                .Include(x => x.Claims)
                .Include(x => x.ClientSecrets)
                .Include(x => x.AllowedScopes)
                .Include(x => x.RedirectUris)
                .Include(x => x.AllowedGrantTypes)
                .Include(x => x.Properties)
                .FirstOrDefaultAsync(x => x.Id == id)
                .ConfigureAwait(false);

            return client;
        }

        private static void CheckId(int id)
        {
            Check.BiggerOrEqual(id, other: 0, nameof(id));
        }
    }
}
