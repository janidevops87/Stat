using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Statline.Common.Utilities;

namespace Statline.Common.Infrastructure.Configuration.Database
{
    public static class SqlServerDbContextOptionsExtensions
    {
        /// <summary>
        /// Configures an SqlServer <see cref="DbContext"/> using configuration system.
        /// </summary>
        /// <param name="optionsBuilder"> The builder being used to configure the context. </param>
        /// <param name="config">The root configuration.</param>
        /// <param name="settingsPath">
        /// The path to the database configuration section 
        /// (relative to <paramref name="config"/>).</param>
        /// <param name="migrationsAssemblyName">The name of migrations assembly.</param>
        /// <returns> The options builder so that further configuration can be chained. </returns>
        /// <remarks>
        /// The key feature of this method is that it allows sharing connection 
        /// strings among many database configurations. This is why you must
        /// provide the root <paramref name="config"/>, so its possible to
        /// find connection strings at default location in the config.
        /// </remarks>
        public static DbContextOptionsBuilder ConfigureSqlServerDbContext(
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

                        sqloptions.EnableRetryOnFailure(
                            databaseSettings.RetryOnFailure.MaxRetryCount,
                            databaseSettings.RetryOnFailure.MaxRetryDelay,
                            errorNumbersToAdd:
                                databaseSettings.RetryOnFailure.AdditionalErrorNumbers ??
                                (ICollection<int>)Array.Empty<int>());

                        sqloptions.CommandTimeout(
                            (int?)databaseSettings.CommandTimeout?.TotalSeconds);
                    });

            return optionsBuilder;
        }
    }
}
