using Microsoft.Extensions.Configuration;
using Statline.Common.Utilities;

namespace Statline.Extensions.Configuration.AzureKeyVault
{
    public static class ConfigurationBuilderExtensions
    {
        public static IConfigurationBuilder AddAzureKeyVaultIfConfigured(
            this IConfigurationBuilder builder,
            string configSectionName,
            string prefixSection = null)
        {
            Check.NotNull(builder, nameof(builder));
            Check.NotEmpty(configSectionName, nameof(configSectionName));

            var config = builder.Build();

            builder.AddAzureKeyVaultIfConfigured(
                config.GetSection(configSectionName),
                prefixSection);

            return builder;
        }

        public static IConfigurationBuilder AddAzureKeyVaultIfConfigured(
            this IConfigurationBuilder builder,
            IConfiguration config,
            string prefixSection = null)
        {
            Check.NotNull(builder, nameof(builder));
            Check.NotNull(config, nameof(config));

            var settings = config.Get<AzureKeyVaultSettings>();

            if (settings != null)
            {
                builder.AddAzureKeyVault(settings, prefixSection);
            }

            return builder;
        }
    }
}
