using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Statline.Common.AppModel.Environment;
using Statline.Common.AppModel.Host;
using Statline.Extensions.Configuration.AzureKeyVault;
using Statline.Extensions.Configuration.Chained;
using Statline.Extensions.Logging;
using System;
using System.Threading.Tasks;

namespace Statline.StatTrac.Api.Func
{
    public class FunctionBase : IDisposable
    {
        private readonly IAppHost appHost;

        protected FunctionBase(
            Microsoft.Azure.WebJobs.ExecutionContext executionContext)
        {
            appHost = new AppHostBuilder()
                .ConfigureAppConfiguration((hostingContext, builder) =>
                {
                    var env = hostingContext.HostingEnvironment;

                    BuildConfiguration(
                        builder,
                        env,
                        executionContext.FunctionAppDirectory);
                })
                .ConfigureServices((hostingContext, services) =>
                {
                    var config = hostingContext.Configuration;

                    ConfigureServices(services, config);
                })
                .ConfigureLogging((hostingContext, builder) =>
                {
                    // TODO: Think how to connect logger infrastructure to
                    // function's TraceWriter (or ILogger).
                    // The difficulty here is that function runtime doesn't 
                    // ask us for a logger factory, DI container etc.
                    // Instead it provides its own logger on each function call.

                    var config = hostingContext.Configuration;

                    builder.AddConfiguration(config.GetSection("Logging"));

                    if (!hostingContext.HostingEnvironment.IsProduction())
                    {
                        builder.AddDebug();
                    }

                    builder.AddAzureWebAppDiagnostics();
                    builder.AddEmailLog(config.GetSection("Logging:Email:Smtp"));
                })
                .Build();
        }

        public void Dispose()
        {
            (appHost as IDisposable)?.Dispose();
        }

        protected virtual void ConfigureServices(
            IServiceCollection services,
            IConfiguration config)
        {
        }

        protected async Task RunAsync(
            Func<IConfiguration, IServiceProvider, Task> action)
        {
            await appHost.RunAppAsync(context =>
                action(context.Configuration, context.ServiceProvider));
        }

        protected async Task RunAsync<TApp>(Func<TApp, Task> action)
        {
            await appHost.RunAppAsync(action);
        }

        private void BuildConfiguration(
            IConfigurationBuilder builder,
            IEnvironment environment,
            string appBaseDirectory)
        {
            var baseBuilder = new ConfigurationBuilder()
                   .SetBasePath(appBaseDirectory)
                   .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
                   .AddJsonFile($"appsettings.{environment.EnvironmentName}.json", optional: true, reloadOnChange: true)
                   .AddEnvironmentVariables();

            // Use base config to load Azure KeyVault settings.
            var baseConfig = baseBuilder.Build();

            // Azure KeyVault should go first to make possible
            // using both KeyVault from test environment with secrets for 
            // external services (like test DB) and hard-coded non-secure 
            // secrets for storage emulators 
            // (which override secrets for test environment).
            builder
                .AddAzureKeyVaultIfConfigured(
                    baseConfig.GetSection("Azure:KeyVault"),
                    prefixSection: "StatTracApiFunc")
                .AddConfiguration(baseConfig);
        }
    }
}
