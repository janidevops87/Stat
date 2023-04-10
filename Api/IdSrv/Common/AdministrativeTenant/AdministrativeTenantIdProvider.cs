using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Statline.Common.Utilities;
using Statline.IdentityServer.IdentityAndAccess.App.Tenants;
using Statline.IdentityServer.IdentityServerConfig.Infrastructure.Persistence.Ef;
using System;

namespace Statline.IdentityServer.Common.AdministrativeTenant
{
    /// <summary>
    /// This is a wrapper for resolving administrative tenant organization name 
    /// provided in config to a tenant id. 
    /// </summary>
    internal class AdministrativeTenantIdProvider : IAdministrativeTenantIdProvider
    {
        private readonly Lazy<int> lazyAdministrativeTenantId;

        public AdministrativeTenantIdProvider(IServiceProvider serviceProvider)
        {
            Check.NotNull(serviceProvider, nameof(serviceProvider));

            // Administrative tenant doesn't change at run time,
            // so we only resolve it once on first need.
            lazyAdministrativeTenantId = new Lazy<int>(() =>
            {
                // Using service provider (AKA Service Locator)
                // is not an anti-pattern here because this is infrastructural
                // code. We use it to narrow down the lifetime of dependencies
                // without introducing this detail to the application code.
                using (var scope = serviceProvider.CreateScope())
                {
                    var configuration =
                        scope.ServiceProvider.GetRequiredService<IConfiguration>();

                    var logger =
                        scope.ServiceProvider.GetRequiredService<ILogger<AdministrativeTenantIdProvider>>();

                    var tenantManagementApplication =
                        scope.ServiceProvider.GetRequiredService<TenantManagementApplication>();

                    var organizationName = configuration.GetValue<string>(
                        "IdentityServer:AdministrativeTenantOrganizationName");

                    logger.LogInformation(
                        "Resolving administrative tenant ID " +
                        "by organization name: '{OrgName}'.", organizationName);

                    // This code will execute only once, and we need it to be synchronous.
                    // So no problem in making the call blocking.
                    var tenantId =
                        tenantManagementApplication.GetTenantIdByOrganizationNameAsync(
                            organizationName).GetAwaiter().GetResult();

                    logger.LogInformation(
                        "Administrative tenant ID " +
                        "was resolved to: {tenantId}.", tenantId);

                    return (int)tenantId;
                }
            });
        }

        public int GetAdministrativeTenantId() => lazyAdministrativeTenantId.Value;
    }
}
