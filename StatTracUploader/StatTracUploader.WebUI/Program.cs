using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Statline.Extensions.Logging;

namespace Statline.StatTracUploader
{
    public class Program
    {
        public static void Main(string[] args)
        {
            CreateHostBuilder(args).Build().Run();
        }

        public static IHostBuilder CreateHostBuilder(string[] args) =>
            Host.CreateDefaultBuilder(args)
                .ConfigureAppConfiguration((context, b) =>
                {
                    var env = context.HostingEnvironment;

                    // Use base config to load Azure KeyVault settings.
                    var baseConfig = b.Build();

                    // Azure KeyVault should go first to make possible
                    // using both KeyVault from test environment with secrets for 
                    // external services (like test DB) and hard-coded non-secure 
                    // secrets for storage emulators 
                    // (which override secrets for test environment).
                    b.Sources.Clear();
                    b.Properties.Clear();

                    b.AddAzureKeyVaultIfConfigured(
                        baseConfig.GetSection("Azure:KeyVault"),
                        "Common", "StatTracUploader");

                    b.AddConfiguration(baseConfig, shouldDisposeConfiguration: true);
                })
                .ConfigureLogging((hostingContext, logging) =>
                {
                    var config = hostingContext.Configuration;
                    logging.AddEmailLog(config, "Logging:Email");
                })
                .ConfigureWebHostDefaults(webBuilder =>
                {
                    webBuilder.UseStartup<Startup>();
                });
    }
}
