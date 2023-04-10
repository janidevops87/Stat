using System;
using System.Collections.Generic;
using System.Text;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Statline.Common.Infrastructure.Configuration.Database;
using Statline.Common.Utilities;
using Statline.Statrac.IdentityServerIntegration.App;

namespace Statline.Statrac.IdentityServerIntegration.Infrastructure.Persistence.Ef
{
    public static class ServiceCollectionExtensions
    {
        public static void AddEfConfigurationRepository(
            this IServiceCollection services,
            IConfiguration config,
            string settingsPath)
        {
            Check.NotNull(services, nameof(services));
            Check.NotNull(config, nameof(config));
            Check.NotEmpty(settingsPath, nameof(settingsPath));

            services.AddDbContext<ConfigurationDbContext>(
                options => options.ConfigureDbContext(config, settingsPath));

            services.AddScoped<IConfigurationRepository, ConfigurationRepository>();
        }

        private static void ConfigureDbContext(
            this DbContextOptionsBuilder optionsBuilder,
            IConfiguration config,
            string settingsPath,
            string migrationsAssemblyName = null)
        {
            Check.NotNull(optionsBuilder, nameof(optionsBuilder));
            Check.NotNull(config, nameof(config));

            var databaseSettings =
                config.GetSqlDatabaseSettings(settingsPath);

            optionsBuilder
                .EnableSensitiveDataLogging(databaseSettings.EnableSensitiveDataLogging)
                .UseSqlServer(
                    databaseSettings.ConnectionString,
                    sqloptions =>
                    {
                        sqloptions.MigrationsAssembly(migrationsAssemblyName);
                        sqloptions.EnableRetryOnFailure();
                    });
        }

    }
}
