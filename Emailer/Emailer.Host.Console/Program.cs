using Autofac;
using Autofac.Extensions.DependencyInjection;
using Emailer.LegacyBridge.App;
using Emailer.LegacyBridge.Infrastructure.EmailMessageQueue;
using Emailer.MessageProcessor.App;
using Emailer.MessageProcessor.Infrastructure.FallbackMessageSender;
using Emailer.MessageProcessor.Infrastructure.MessageSender.EmailService;
using Emailer.MessageProcessor.Infrastructure.RetryMessageSender;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using System;
using System.Threading;
using System.Threading.Tasks;

namespace Emailer.Host.Console
{
    class Program : IAsyncDisposable
    {
        private static readonly TimeSpan LoggersFlushTimeout = TimeSpan.FromSeconds(10);

        private ILogger? logger;
        private readonly IHost host;
        private const string applicationName = "Emailer";

        public static async Task Main(string[] args)
        {
            await using var program = new Program(args);
            await program.RunAsync();
        }

        public Program(string[] args)
        {
            host = CreateHostBuilder(args).Build();

            logger = host.Services.GetRequiredService<ILogger<Program>>();

            AppDomain.CurrentDomain.UnhandledException += CurrentDomain_UnhandledException;
        }

        public async ValueTask DisposeAsync()
        {
            if (host is IAsyncDisposable disposable) await disposable.DisposeAsync();

            // At this point the logger is disposed and
            // should not be used.
            logger = null;
        }

        public async Task RunAsync()
        {
            logger?.LogTrace("Emailer Started");
            try
            {
                await RunAsyncCore();
            }
            catch (Exception ex)
            {
                // Log before the logger is disposed.
                LogUnhandledException(ex, "Program.RunAsync");
                throw;
            }
        }

        private async Task RunAsyncCore()
        {
            await host.StartAsync();

            var scope = host.Services.CreateScope();

            await using (scope as IAsyncDisposable)
            {
                var messageForwardingApp =
                    scope.ServiceProvider.GetRequiredService<MessageForwardingApp>();

                await messageForwardingApp.ForwardPendingMessagesAsync(cancellationToken: default);
            }

            await host.StopAsync();
        }

        public static IHostBuilder CreateHostBuilder(string[] args)
        {
            return Microsoft.Extensions.Hosting.Host.CreateDefaultBuilder(args)
                .UseServiceProviderFactory(new AutofacServiceProviderFactory())
                .ConfigureAppConfiguration((context, b) =>
                {
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
                        "Emailer");

                    b.AddConfiguration(baseConfig, shouldDisposeConfiguration: true);
                })
                .ConfigureLogging((context, b) =>
                {
                    b.AddAzureWebAppDiagnostics();
                })
                .ConfigureServices((hostContext, services) =>
                {
                    services.AddWebJobNameTelemetryInitializer(applicationName);
                    services.AddApplicationInsightsTelemetryWorkerService(hostContext.Configuration);
                    AddApplicationServices(services, hostContext.Configuration);
                })
                .ConfigureContainer<ContainerBuilder>((context, container) =>
                {
                    var config = context.Configuration;

                    AddAutofacApplicationServices(container, config);
                });
        }

        private static void AddAutofacApplicationServices(
            ContainerBuilder containerBuilder,
            IConfiguration config)
        {
            containerBuilder.AddRetryMessageSenderDecorator(config.GetSection("RetryMessageSender"));
            containerBuilder.AddFallbackMessageSenderDecorator(config.GetSection("FallbackMessageSender"));
        }

        private static void AddApplicationServices(
            IServiceCollection services,
            IConfiguration configuration)
        {
            services.AddLegacyEmailMessageQueue(configuration, "LegacyMessageQueue:DbSettings");
            services.AddMessageForwardingApp();
            services.AddEmailServiceMessageSender(configuration.GetSection("EmailServiceMessageSender"));
            services.AddDonorTracApiEmailService(
                        clientConfig: configuration.GetSection("DonorTracApiClient"),
                        authConfig: configuration.GetSection("DonorTracApiClient:Authentication"));
            services.AddMessageProcessorApp(configuration.GetSection("MessageProcessor"));
            services.AddScoped<IMessageForwardingService, AppToAppMessageForwardingService>();
        }

        // This is primarily for logging unhandled exceptions from background threads.
        // There is dedicated handler for call stacks rooted in Main.
        private void CurrentDomain_UnhandledException(object sender, UnhandledExceptionEventArgs e)
        {
            LogUnhandledException((Exception)e.ExceptionObject, "AppDomain.CurrentDomain.UnhandledException");

            // Give some time for the loggers to flush
            // the logs (that's primarily related to Email Logger).
            Thread.Sleep(LoggersFlushTimeout);
        }

        private void LogUnhandledException(Exception ex, string loggedBy)
        {
            logger?.LogCritical(ex,
                $"An unhandled exception happened. The program will stop. Logged by {loggedBy}");
        }
    }
}
