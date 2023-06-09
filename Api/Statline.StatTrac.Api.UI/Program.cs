﻿using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using Statline.Common.Infrastructure.Azure.ApplicationIsights;
using Statline.Extensions.Configuration.AzureKeyVault;
using System.IO;

namespace Statline.StatTrac.Api.UI
{
    public class Program
    {
        public static void Main(string[] args)
        {
            // This pattern is needed for CLI tools like EF tools.
            CreateWebHostBuilder(args).Build().Run();
        }

        public static IWebHostBuilder CreateWebHostBuilder(string[] args) =>
            new WebHostBuilder()
                .ConfigureAppConfiguration((hostingContext, config) =>
                {
                    var env = hostingContext.HostingEnvironment;

                    config.AddJsonFile("appsettings.json", optional: true, reloadOnChange: true)
                        .AddJsonFile($"appsettings.{env.EnvironmentName}.json", optional: true, reloadOnChange: true)
                        .AddEnvironmentVariables()
                        .AddAzureKeyVaultIfConfigured("Azure:KeyVault");
                })
                .ConfigureLogging((hostingContext, logging) =>
                {
                    logging.AddConfiguration(hostingContext.Configuration.GetSection("Logging"));

                    logging.AddConsole();
                    logging.AddDebug();
                })
                .UseApplicationInsightsWithConfig("Azure:ApplicationInsights")
                .UseKestrel()
                .UseContentRoot(Directory.GetCurrentDirectory())
                .UseIISIntegration()
                .UseStartup<Startup>();
    }
}
