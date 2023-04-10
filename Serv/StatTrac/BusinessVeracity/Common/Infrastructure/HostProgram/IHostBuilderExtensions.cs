using Autofac;
using Autofac.Extensions.DependencyInjection;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.DependencyInjection.Extensions;
using Statline.Common.Services;
using Statline.Extensions.Logging;
using Statline.StatTrac.BusinessVeracity.Common.Infrastructure;
using Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ApiClients.InContactApi;
using Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ApiClients.StatTracApi;
using Statline.StatTrac.BusinessVeracity.Common.Infrastructure.CallInformation.InContactPreloaded;
using Statline.StatTrac.BusinessVeracity.Common.Infrastructure.HostProgram.ApplicationState;

namespace Microsoft.Extensions.Hosting;

public static class IHostBuilderExtensions
{
    public static IHostBuilder ConfigureReferralProcessorApplicationHost(
        this IHostBuilder hostBuilder,
        string appName,
        Action<IServiceCollection, IConfiguration, IHostEnvironment> configureApplicationServices,
        Action<ContainerBuilder, IConfiguration, IHostEnvironment>? configureAutofacApplicationServices = null)
    {
        Check.NotNull(hostBuilder, nameof(hostBuilder));
        Check.NotEmpty(appName, nameof(appName));
        Check.NotNull(configureApplicationServices, nameof(configureApplicationServices));

        return hostBuilder
            .UseServiceProviderFactory(new AutofacServiceProviderFactory())
            .ConfigureAppConfiguration((context, builder) =>
            {
                var defaultConfig = builder.Build();

                // This is needed to be added two times for Azure KeyVault settings.
                builder.AddSharedConfigs(context.HostingEnvironment);
                // Use base config to load Azure KeyVault settings.
                var configForAzure = builder.Build();

                // Clear existing sources to put shared configs first.
                builder.Sources.Clear();
                builder.AddSharedConfigs(context.HostingEnvironment);
                // Now add the default configuration back.
                builder.AddConfiguration(defaultConfig);
                builder.AddAzureKeyVaultIfConfigured(
                    configForAzure.GetSection("Azure:KeyVault"),
                    appName);
            })
            .ConfigureLogging((context, b) =>
            {
                var config = context.Configuration;
                b.AddAzureWebAppDiagnostics();
                b.AddEmailLog(config, "Logging:Email");
            })
            .ConfigureServices((hostContext, services) =>
            {
                services.AddWebJobNameTelemetryInitializer(appName);
                services.AddApplicationInsightsTelemetryWorkerService(hostContext.Configuration);
                ConfigureCommonApplicationServices(services, hostContext.Configuration, hostContext.HostingEnvironment);
                configureApplicationServices(services, hostContext.Configuration, hostContext.HostingEnvironment);
            })
            .ConfigureContainer<ContainerBuilder>((hostContext, container) =>
            {
                configureAutofacApplicationServices?.Invoke(
                    container,
                    hostContext.Configuration,
                    hostContext.HostingEnvironment);
            });
    }

    private static void ConfigureCommonApplicationServices(
        IServiceCollection services, 
        IConfiguration configuration, 
        IHostEnvironment hostingEnvironment)
    {
        services.TryAddSingleton<IDateTimeService, DateTimeService>();

        services.AddJsonFileApplicationStateStorage(
            configuration.GetSection("ApplicationSettings:StateStorage"));

        services.AddInContactApiClient(
            clientConfig: configuration.GetSection("InContactApiClient"),
            authConfig: configuration.GetSection("InContactApiClient:Authentication"));

        services.AddInContactPreloadedCallInformationProvider();

        services.AddStatTracApiClient(
            clientConfig: configuration.GetSection("StatTracApiClient"),
            authConfig: configuration.GetSection("StatTracApiClient:Authentication"));

        services.AddMailKitNotificationService(configuration, "Notification");
    }

    private static void AddSharedConfigs(
            this IConfigurationBuilder builder,
            IHostEnvironment env)
    {
        builder.AddJsonFile("appsettingsCommon.json", optional: false);
        builder.AddJsonFile($"appsettingsCommon.{env.EnvironmentName}.json", optional: true);
    }
}
