using System;
using System.Threading.Tasks;
using IdentityServer4.EntityFramework.Entities;
using Statline.IdentityServer.IdentityServerConfig.Domain.Model;

namespace Statline.IdentityServer.IdentityServerConfig.App.Resources.Api
{
    internal static class ApiResourceRepositoryExtensions
    {
        public static async Task<ApiResource> GetById(
            this IApiResourceRepository apiResourceRepository, 
            int apiResourceId)
        {
            var apiResource = await apiResourceRepository.FindByIdAsync(apiResourceId);

            if (apiResource == null)
            {
                throw new ArgumentException(
                    $"API Resource with id '{apiResourceId}' wasn't found.", nameof(apiResourceId));
            }

            return apiResource;
        }
    }
}
