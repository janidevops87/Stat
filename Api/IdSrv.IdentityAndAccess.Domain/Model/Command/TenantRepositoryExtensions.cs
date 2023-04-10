using System;
using System.Threading.Tasks;
using Statline.Common.Utilities;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Common;

namespace Statline.IdentityServer.IdentityAndAccess.Domain.Model.Command
{
    public static class TenantRepositoryExtensions
    {
        public static async Task<Tenant> GetByIdAsync(
            this ITenantRepository tenantRepository,
            TenantId tenantId)
        {
            Check.NotNull(tenantRepository, nameof(tenantRepository));
            Check.NotNull(tenantId, nameof(tenantId));

            var tenant = await tenantRepository.FindByIdAsync(tenantId);

            if (tenant == null)
            {
                throw new ArgumentException(
                    $"Tenant with id '{tenantId}' wasn't found.", nameof(tenantId));
            }

            return tenant;
        }

        public static async Task<Tenant> GetByIdOrganizationNameAsync(
            this ITenantRepository tenantRepository,
            string organizationName)
        {
            Check.NotEmpty(organizationName, nameof(organizationName));

            var tenant = await tenantRepository.FindByOrganizationNameAsync(organizationName);

            if (tenant == null)
            {
                throw new ArgumentException(
                    $"Tenant with organization name '{organizationName}' " +
                    $"wasn't found.", nameof(organizationName));
            }

            return tenant;
        }
    }
}
