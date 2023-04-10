using Microsoft.Extensions.Configuration;
using System;
using System.Data.SqlClient;

namespace Statline.Common.Infrastructure.Configuration.Database
{
    public static class ConfigurationExtensions
    {
        public static DatabaseSettings GetSqlDatabaseSettings(
            this IConfiguration configuration,
            string settingsPath)
        {
            var section = configuration.GetSection(settingsPath);

            var dbSettings = section.Get<DatabaseSettingsRaw>();

            if (dbSettings == null)
            {
                throw new ArgumentException(
                    $"Database settings were not found at path '{settingsPath}'.",
                    nameof(settingsPath));
            }

            var connectionString = configuration.GetConnectionString(
                dbSettings.ConnectionStringName,
                settingsPath);

            var csb = new SqlConnectionStringBuilder(connectionString);

            ApplyConnectionStringSettings(
                csb,
                configuration,
                dbSettings.ConnectionStringName);

            ApplyDbSettingsToConnectionString(csb, dbSettings);

            return new DatabaseSettings
            {
                ConnectionString = csb.ToString(),
                EnableSensitiveDataLogging = dbSettings.EnableSensitiveDataLogging,
                CommandTimeout = dbSettings.CommandTimeout,
                RetryOnFailure = dbSettings.RetryOnFailure ?? new RetryOnFailureSettings()
            };
        }

        private static void ApplyConnectionStringSettings(
            SqlConnectionStringBuilder csb,
            IConfiguration configuration,
            string connectionStringName)
        {
            // Here we are trying to find configuration string properties
            // at a well-known path. These properties are not intended to 
            // be specified as part of ConnectionStrings section in a JSON file,
            // but work nice with key vault.
            //
            // TODO: This approach is not ideal, but avoids creating 
            // separate model for connection strings. Should be turned
            // into less tricky design when needed.

            var passwordPath =
               $"ConnectionStrings:{connectionStringName}:Password";

            var password = configuration[passwordPath];

            if (password != null && !csb.IntegratedSecurity)
            {
                csb.Password = password;
            }
        }

        private static void ApplyDbSettingsToConnectionString(
            SqlConnectionStringBuilder csb,
            DatabaseSettingsRaw dbSettings)
        {
            if (!csb.IntegratedSecurity &&
                dbSettings.Credential != null)
            {
                if (dbSettings.Credential.Password != null)
                {
                    csb.Password = dbSettings.Credential.Password;
                }

                if (dbSettings.Credential.UserName != null)
                {
                    csb.UserID = dbSettings.Credential.UserName;
                }
            }

            if (dbSettings.DatabaseName != null)
            {
                csb.InitialCatalog = dbSettings.DatabaseName;
            }
        }

        private static string GetConnectionString(
            this IConfiguration configuration,
            string connectionStringName,
            string referencingSettingsPath)
        {
            if (string.IsNullOrWhiteSpace(connectionStringName))
            {
                throw new InvalidOperationException(
                    $"Connection string name is not specified in " +
                    $"the database settings at path '{referencingSettingsPath}'.");
            }

            var connectionString =
                configuration.GetConnectionString(connectionStringName);

            if (connectionString == null)
            {
                throw new InvalidOperationException(
                    $"Connection string with name {connectionString} was not found.");

            }

            if (string.IsNullOrWhiteSpace(connectionString))
            {
                throw new InvalidOperationException(
                    $"Connection string with name {connectionString} is empty.");
            }

            return connectionString;
        }
    }
}
