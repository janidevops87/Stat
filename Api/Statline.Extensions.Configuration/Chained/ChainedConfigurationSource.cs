// NOTE: This chained config support was taken from Microsoft pre-release sources
// (see https://github.com/aspnet/Configuration/pull/719).
// This functionality is expected to appear in v2.1 of the package.
// Once its released, this implementation should be removed.

using Microsoft.Extensions.Configuration;

namespace Statline.Extensions.Configuration.Chained
{
    /// <summary>
    /// Represents a chained IConfiguration as an <see cref="IConfigurationSource"/>.
    /// </summary>
    public class ChainedConfigurationSource : IConfigurationSource
    {
        /// <summary>
        /// The chained configuration.
        /// </summary>
        public IConfiguration Configuration { get; set; }

        /// <summary>
        /// Builds the <see cref="ChainedConfigurationProvider"/> for this source.
        /// </summary>
        /// <param name="builder">The <see cref="IConfigurationBuilder"/>.</param>
        /// <returns>A <see cref="ChainedConfigurationProvider"/></returns>
        public IConfigurationProvider Build(IConfigurationBuilder builder)
        {
            return new ChainedConfigurationProvider(this);
        }
    }
}
