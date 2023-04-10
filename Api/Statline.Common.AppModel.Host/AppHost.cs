using System;
using System.Threading.Tasks;
using Statline.Common.AppModel.Environment;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Logging.Abstractions;
using Statline.Common.Utilities;

namespace Statline.Common.AppModel.Host
{
    internal class AppHost : IAppHost
    {
        private readonly ServiceCollection applicationServices;
        private readonly ServiceProvider hostingServiceProvider;
        private readonly IConfiguration config;
        private readonly ILogger logger;
        private readonly IEnvironment hostingEnvironment;

        public AppHost(
            ServiceCollection applicationServices,
            ServiceProvider hostingServiceProvider,
            IConfiguration config)
        {
            this.applicationServices = applicationServices;
            this.hostingServiceProvider = hostingServiceProvider;
            this.config = config;

            logger =
                (ILogger)hostingServiceProvider.GetService<ILogger<AppHost>>() ??
                NullLogger.Instance;

            hostingEnvironment = 
                hostingServiceProvider.GetRequiredService<IEnvironment>();
        }

        public async Task RunAppAsync(
            Func<AppHostContext, Task> runCallback)
        {
            Check.NotNull(runCallback, nameof(runCallback));

            logger.LogInformation(
                "Application is starting with environment: {env}", 
                hostingEnvironment.EnvironmentName);

            var context = new AppHostContext(
                hostingServiceProvider,
                config);

            try
            {
                await runCallback(context);
            }
            catch (Exception ex)
            {
                logger.LogCritical(ex, "Application has encountered an unhandled exception");
                throw;
            }
        }
    }
}
