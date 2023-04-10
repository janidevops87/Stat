// NOTE: This chained config support was taken from Microsoft pre-release sources
// (see https://github.com/aspnet/Configuration/pull/719).
// This functionality is expected to appear in v2.1 of the package.
// Once its released, this implementation should be removed.

using Microsoft.Extensions.Configuration;
using System;

namespace Statline.Extensions.Configuration.Chained
{
    /// <summary>
    /// IConfigurationBuilder extension methods.
    /// </summary>
    public static class ConfigurationBuilderExtensions
    {
        /// <summary>
        /// Adds an existing configuration to <paramref name="configurationBuilder"/>.
        /// </summary>
        /// <param name="configurationBuilder">The <see cref="IConfigurationBuilder"/> to add to.</param>
        /// <param name="config">The <see cref="IConfiguration"/> to add.</param>
        /// <returns>The <see cref="IConfigurationBuilder"/>.</returns>
        [Obsolete("This API should be replaced with Microsoft's in-box version.")]
        public static IConfigurationBuilder AddConfiguration(this IConfigurationBuilder configurationBuilder, IConfiguration config)
        {
            if (configurationBuilder == null)
            {
                throw new ArgumentNullException(nameof(configurationBuilder));
            }
            if (config == null)
            {
                throw new ArgumentNullException(nameof(config));
            }

            configurationBuilder.Add(new ChainedConfigurationSource { Configuration = config });
            return configurationBuilder;
        }
    }
}
