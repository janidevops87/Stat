using System;
using System.Threading.Tasks;
using IdentityServer4.EntityFramework.Entities;
using Statline.IdentityServer.IdentityServerConfig.Domain.Model;

namespace Statline.IdentityServer.IdentityServerConfig.App.Clients
{
    internal static class ClientRepositoryExtensions
    {
        public static async Task<Client> GetById(
            this IClientRepository clientRepository, 
            int id)
        {
            var client = await clientRepository.FindByIdAsync(id);

            if (client == null)
            {
                throw new ArgumentException(
                    $"Client with id '{id}' wasn't found.", nameof(id));
            }

            return client;
        }
    }
}
