using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Azure.KeyVault;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.Azure.Services.AppAuthentication;
using Microsoft.Extensions.Configuration.AzureKeyVault;

namespace Statline.Ereferral.Web
{
    public class Program
    {
        public static void Main(string[] args)
        {
            CreateHostBuilder(args).Build().Run();
        }

        public static IHostBuilder CreateHostBuilder(string[] args) =>
            Host.CreateDefaultBuilder(args)
            .ConfigureAppConfiguration((context, config) =>
            {
                // Add KeyVault if it exists
                IHostEnvironment env = context.HostingEnvironment;
                var builtConfig = config.SetBasePath(Directory.GetCurrentDirectory())
                    .AddJsonFile("appsettings.json", optional: false)
                    .AddJsonFile($"appsettings.{env.EnvironmentName}.json", optional: true)
                    .AddUserSecrets<Startup>()
                    .AddEnvironmentVariables()
                    .Build();

                if (builtConfig.GetSection("KeyVault").GetChildren().Count() == 2)
                {
                    var keyVaultEndpoint = $"https://{builtConfig["KeyVault:Vault"]}.vault.azure.net/";
                    if (!string.IsNullOrEmpty(keyVaultEndpoint))
                    {
                        var azureServiceTokenProvider = new AzureServiceTokenProvider();
                        var keyVaultClient = new KeyVaultClient(
                            new KeyVaultClient.AuthenticationCallback(
                                azureServiceTokenProvider.KeyVaultTokenCallback));
                        config.AddAzureKeyVault(
                           keyVaultEndpoint, keyVaultClient, new DefaultKeyVaultSecretManager());
                    }
                }
            })
                .ConfigureWebHostDefaults(webBuilder =>
                {
                    webBuilder.UseStartup<Startup>();
                });
    }
}
