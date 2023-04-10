using System;
using Microsoft.Extensions.Configuration;
using Statline.Common.Utilities;

namespace Statline.Common.AppModel.Host
{
    public class AppHostContext
    {
        public IServiceProvider ServiceProvider { get; }
        public IConfiguration Configuration { get; }

        public AppHostContext(
            IServiceProvider serviceProvider,
            IConfiguration configuration)
        {
            Check.NotNull(serviceProvider, nameof(serviceProvider));
            Check.NotNull(configuration, nameof(configuration));
            ServiceProvider = serviceProvider;
            Configuration = configuration;
        }
    }
}
