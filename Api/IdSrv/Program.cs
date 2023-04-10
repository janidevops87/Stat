using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Statline.Extensions.Logging;
using Statline.IdentityServer.IdentityAndAccess.App.Bootstrap;
using System;
using System.Threading.Tasks;

namespace Statline.IdentityServer
{
    public class Program
    {
        public static async Task Main(string[] args)
        {
            if (DoBootstrap(args))
            {
                IHost host = CreateConsoleHostBuilder(args).Build();

                using (host)
                {
                    LogHostingEnvironment(host.Services);

                    await RunApplicationBootstrap(host);
                }
            }
            else
            {
                IHost host = CreateWebHostBuilder(args).Build();

                using (host)
                {
                    LogHostingEnvironment(host.Services);

                    await host.RunAsync();
                }
            }
        }

        private static bool DoBootstrap(string[] args)
        {
            return new ConfigurationBuilder()
                    .AddCommandLine(args)
                    .Build()
                    .GetValue<bool>("bootstrap");
        }

        private static async Task RunApplicationBootstrap(IHost host)
        {
            var sp = host.Services;

            await host.StartAsync();

            var deploymentApp = sp.GetRequiredService<BootstrapApplication>();

            await deploymentApp.ProvisionInitialConfigurationAsync();

            await host.StopAsync();
        }

        // Currently there are IWebHost and IHost, which are 
        // similar but still different types. So instead of passing host
        // here we pass the service provider.
        private static void LogHostingEnvironment(IServiceProvider sp)
        {
            var logger = sp.GetRequiredService<ILogger<Program>>();
            var env = sp.GetRequiredService<IHostEnvironment>();

            logger.LogInformation($"Environment name is: {env.EnvironmentName}");
        }

        private static IHostBuilder CreateConsoleHostBuilder(string[] args)
        {
            return Host.CreateDefaultBuilder(args)
                .ConfigureAppConfiguration((hostingContext, configBuilder) =>
                    ConfigureAppConfigurationCommon(
                        hostingContext.HostingEnvironment.EnvironmentName,
                        hostingContext.Configuration,
                        configBuilder))
                .ConfigureLogging((hostingContext, logging) =>
                    ConfigureLoggingCommon(hostingContext.Configuration, logging))
                .ConfigureServices((hostingContext, services) =>
                {
                    var startup = new Startup(
                        hostingContext.Configuration,
                        hostingContext.HostingEnvironment);

                    startup.ConfigureApplicationServices(services);
                    startup.ConfigureCommonServices(services);
                })
                .UseConsoleLifetime();
        }

        // This pattern is needed for CLI tools like EF tools.
        public static IHostBuilder CreateWebHostBuilder(string[] args)
        {
            return Host.CreateDefaultBuilder(args)
                .ConfigureAppConfiguration((hostingContext, configBuilder) =>
                    ConfigureAppConfigurationCommon(
                        hostingContext.HostingEnvironment.EnvironmentName,
                        hostingContext.Configuration,
                        configBuilder))
                .ConfigureLogging((hostingContext, logging) =>
                    ConfigureLoggingCommon(hostingContext.Configuration, logging))
                 .ConfigureWebHostDefaults(webBuilder =>
                 {
                     webBuilder.UseStartup<Startup>();
                 });
        }

        private static void ConfigureAppConfigurationCommon(
            string environmentName,
            IConfiguration hostConfig,
            IConfigurationBuilder configBuilder)
        {
            bool isDevEnvironment = environmentName == Environments.Development;

            // This setting can be used to disable key vault during 
            // development to make app launch faster. In that case, user
            // secrets provider will usually have all needed.
            if (!hostConfig.GetValue<bool>("noKeyVault") ||
                !isDevEnvironment)
            {
                configBuilder.AddAzureKeyVaultIfConfigured("Azure:KeyVault");
            }
        }

        private static void ConfigureLoggingCommon(
            IConfiguration config,
            ILoggingBuilder logging)
        {
           
            logging.AddEmailLog(config, "Logging:Email");
        }
    }
}
