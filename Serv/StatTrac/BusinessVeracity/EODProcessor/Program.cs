// See https://aka.ms/new-console-template for more information

using Autofac;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Statline.StatTrac.BusinessVeracity.Common.Application;
using Statline.StatTrac.BusinessVeracity.Common.Infrastructure.FileStorage.Local;
using Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ReferralOutput.Composite;
using Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ReferralOutput.JsonFile;
using Statline.StatTrac.BusinessVeracity.EodProcessor.Application;
using Statline.StatTrac.BusinessVeracity.EodProcessor.Infrastructure.FileStorage.AmazonS3;
using Statline.StatTrac.BusinessVeracity.EodProcessor.Infrastructure.ReferralSource.StatTracApi;

using var host = CreateHostBuilder(args).Build();

await host.RunApplicationAsync().ConfigureAwait(false);

static IHostBuilder CreateHostBuilder(string[] args)
{
    return Host.CreateDefaultBuilder(args)
        .ConfigureReferralProcessorApplicationHost(
            GlobalConstants.ApplicationName, 
            AddApplicationServices,
            AddAutofacApplicationServices);
}

static void AddApplicationServices(
    IServiceCollection services,
    IConfiguration configuration,
    IHostEnvironment environment)
{
    services.AddEodProcessorApplication(
        configuration.GetSection("ApplicationSettings"));

    if (environment.IsDevelopment() || environment.IsEnvironment("TestLocal"))
    {
        services.AddLocalFileStorage(
            configuration.GetSection("FileStorage:Local"));
    }
    else
    {
        services.AddAmazonS3FileStorage(
            configuration.GetSection("FileStorage:AmazonS3"));
    }

    services.AddStatTracApiReferralSource();
}

static void AddAutofacApplicationServices(
    ContainerBuilder container,
    IConfiguration configuration,
    IHostEnvironment environment)
{
    container.AddJsonFileReferralOutputNamed(
        configuration.GetSection("ReferralOutput:JsonFileNightlyMetadataFeed"), "NightlyMetadataFeed");

    container.AddJsonFileReferralOutputNamed(
        configuration.GetSection("ReferralOutput:JsonFileDailyExportAllCalls"), "DailyExportAllCalls");

    container.RegisterGenericComposite(typeof(CompositeReferralOutput<>), typeof(IReferralOutput<>));
}