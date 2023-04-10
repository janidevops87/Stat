using System;
using System.Threading.Tasks;
using IdentityServer4.EntityFramework.Entities;
using Statline.IdentityServer.IdentityServerConfig.Domain.Model;

namespace Statline.IdentityServer.IdentityServerConfig.App.Resources.Identity
{
    internal static class IdentityResourceRepositoryExtensions
    {
        public static async Task<IdentityResource> GetById(
            this IIdentityResourceRepository identityResourceRepository, 
            int identityResourceId)
        {
            var identityResource = await identityResourceRepository.FindByIdAsync(identityResourceId);

            if (identityResource == null)
            {
                throw new ArgumentException(
                    $"Identity Resource with id '{identityResourceId}' wasn't found.", nameof(identityResourceId));
            }

            return identityResource;
        }
    }
}
