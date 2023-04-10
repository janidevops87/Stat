using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Statline.Extensions.Logging;

namespace Statline.StatTrac.Api;

public class Program
{
    public static void Main(string[] args)
    {
        // This pattern is needed for CLI tools like EF tools.
        CreateHostBuilder(args).Build().Run();
    }

    public static IHostBuilder CreateHostBuilder(string[] args) =>
                    Host.CreateDefaultBuilder(args)
             .ConfigureWebHostDefaults(webBuilder =>
             {
                 webBuilder.UseStartup<Startup>();
             })
            .ConfigureAppConfiguration((hostingContext, builder) =>
            {
                var env = hostingContext.HostingEnvironment;
                
                // Default host builder adds user secrets for
                // dev environment only.
                if (env.IsEnvironment("TestLocal"))
                {
                    builder.AddUserSecrets<Program>();
                }

                PrependAzureKeyVault(env, builder);
            })
            .ConfigureLogging((hostingContext, logging) =>
            {
                var config = hostingContext.Configuration;

                logging.AddConfiguration(config.GetSection("Logging"));

                logging.AddConsole();
                logging.AddDebug();
                logging.AddEmailLog(config, "Logging:Email");
            });

    private static void PrependAzureKeyVault(IHostEnvironment env, IConfigurationBuilder builder)
    {
        // Use base config to load Azure KeyVault settings.
        var baseConfig = builder.Build();

        // Loading secrets from azure key vault adds
        // noticeable delay on each app start. So we prefer
        // user secrets provider during development.
        if (env.IsDevelopment() || env.IsEnvironment("TestLocal"))
        {
            // We don't want a developer who downloaded fresh sources
            // to investigate why some parts of the app are not getting
            // needed credentials. Therefore, if local user secrets were
            // not filled and explicitly marked as such, fall back to
            // key vault secrets. This can also be used to test with key
            // vault in dev environment if we want.
            if (baseConfig["UserSecretsInitializedMarker"] is not null)
            {
                return;
            }

            // TODO: Log warning to bring attention to development
            // life cycle slowdown.
        }

        // Clear existing sources to put key vault first.
        builder.Sources.Clear();

        // Azure KeyVault should go first to make possible
        // using both KeyVault from test environment with secrets for 
        // external services (like test DB) and hard-coded non-secure 
        // secrets for storage emulators 
        // (which override secrets for test environment).
        builder.AddAzureKeyVaultIfConfigured(
            baseConfig.GetSection("Azure:KeyVault"),
                "StatTracApi",
                "Common");
        // Now add the default configuration back.
        builder.AddConfiguration(baseConfig);
    }
}
