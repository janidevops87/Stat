using System;
using Microsoft.Extensions.DependencyInjection;
using Statline.Common.Utilities;

namespace Statline.IdentityServer.IdentityServerConfig.Infrastructure.Persistence.Ef
{
    public static class ServiceCollectionExtensions
    {
        public static void AddMultiTenantConfigurationDbContext(
            this IServiceCollection services,
            Action<MultiTenantConfigurationStoreOptions> storeOptionsAction)
        {
            Check.NotNull(services, nameof(services));
            Check.NotNull(storeOptionsAction, nameof(storeOptionsAction));

            /// The code below resembles the 
            /// <see cref="IdentityServerEntityFrameworkBuilderExtensions.AddConfigurationStore{TContext}(IIdentityServerBuilder, Action{ConfigurationStoreOptions})"/>
            /// extension method from IdentityServer, but excludes
            /// registering store implementations.

            // TODO: IdentityServer will add its own instance too,
            // so need to think how to make this only once.
            // Otherwise last registration wins.
            var options = new MultiTenantConfigurationStoreOptions();
            services.AddSingleton(options);
            storeOptionsAction?.Invoke(options);

            if (options.ResolveDbContextOptions != null)
            {
                services.AddDbContext<MultiTenantConfigurationDbContext>(
                    options.ResolveDbContextOptions, 
                    optionsLifetime: ServiceLifetime.Singleton);
            }
            else
            {
                services.AddDbContext<MultiTenantConfigurationDbContext>(
                    dbCtxBuilder => options.ConfigureDbContext?.Invoke(dbCtxBuilder),
                    optionsLifetime: ServiceLifetime.Singleton);
            }
        }
    }
}
