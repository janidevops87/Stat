using Microsoft.Practices.EnterpriseLibrary.Common.Configuration;
using Microsoft.Practices.EnterpriseLibrary.Data.Configuration;
using Microsoft.Practices.EnterpriseLibrary.Data.Configuration.Fluent;
using System.Configuration;
using System.Data.SqlClient;

namespace Statline.Framework.Transformation.Connection
{
    public class TransformSqlConnection
    {
        public IConfigurationSource UpdatePasswordConnectionString(string databaseName, string transformText = "")
        {
            ConfigurationSourceBuilder builder = new ConfigurationSourceBuilder();
            IDataConfiguration dataConfig = builder.ConfigureData();

            var connectionString = CopyCurrentDataConfiguration(dataConfig, databaseName);
            connectionString = GetUpdatedConnectionString(connectionString, transformText);            

            // Add our database connections to the builder
            dataConfig
              .ForDatabaseNamed(databaseName)
              .ThatIs
              .ASqlDatabase()
              .WithConnectionString(connectionString);

            // Create a new configuration source, update it with the builder and make it the current configuration
            var newConfigSource = new DictionaryConfigurationSource();
            builder.UpdateConfigurationWithReplace(newConfigSource);
            return newConfigSource;
        }

        public static string GetUpdatedConnectionString(string connectionString, string transformText)
        {            
            if (!string.IsNullOrEmpty(transformText))
            {
                var csb = new SqlConnectionStringBuilder(connectionString);
                csb.Password = transformText;
                connectionString = csb.ToString();
            }
            return connectionString;
        }

        private static string CopyCurrentDataConfiguration(IDataConfiguration dataConfig, string databaseName)
        {
            // Load the configuration from the configuration file
            var configSource = ConfigurationSourceFactory.Create();

            // Retrieve the default datasource name
            var dataConfigurationSection = (DatabaseSettings)configSource.GetSection(DatabaseSettings.SectionName);
            var defaultDatabaseName = dataConfigurationSection.DefaultDatabase;

           return CopyConnectionStrings(dataConfig, !string.IsNullOrEmpty(databaseName) ? databaseName : defaultDatabaseName);
        }

        private static string CopyConnectionStrings(IDataConfiguration dataConfig, string defaultDatabaseName)
        {
            // Add the configurations from our application config file to the builder
            foreach (ConnectionStringSettings settings in ConfigurationManager.ConnectionStrings)
            {
                // When running in some environments (e.g. Azure App Service)
                // some connection strings from the environment may contain 
                // no properties except name (e.g. MySQLRoleProvider as default 
                // role provider when unconfigured), so we skip these.
                if (string.IsNullOrEmpty(settings.ProviderName))
                    continue;

                var configuredDatabase = dataConfig
                  .ForDatabaseNamed(settings.Name)
                  .ThatIs
                  .AnotherDatabaseType(settings.ProviderName);

                if (settings.Name.Equals(defaultDatabaseName))
                {
                    configuredDatabase.AsDefault();
                    return settings.ConnectionString;
                }
            }
            return string.Empty;
        }
    }
}
