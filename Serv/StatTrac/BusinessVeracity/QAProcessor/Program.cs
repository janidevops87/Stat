// See https://aka.ms/new-console-template for more information

using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Statline.StatTrac.BusinessVeracity.Common.Infrastructure.FileStorage.Local;
using Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ReferralOutput.JsonFile;
using Statline.StatTrac.BusinessVeracity.QAProcessor;
using Statline.StatTrac.BusinessVeracity.QAProcessor.Application;
using Statline.StatTrac.BusinessVeracity.QAProcessor.Infrastructure.ApiClients.VoxJarApi;
using Statline.StatTrac.BusinessVeracity.QAProcessor.Infrastructure.ReferralOutput.VoxJar;
using Statline.StatTrac.BusinessVeracity.QAProcessor.Infrastructure.ReferralSource.StatTracApi;

using var host = CreateHostBuilder(args).Build();

await host.RunApplicationAsync().ConfigureAwait(false);

static IHostBuilder CreateHostBuilder(string[] args)
{
    return Host.CreateDefaultBuilder(args)
        .ConfigureReferralProcessorApplicationHost(
            GlobalConstants.ApplicationName,
            AddApplicationServices);
}

static void AddApplicationServices(
       IServiceCollection services,
       IConfiguration configuration,
       IHostEnvironment environment)
{
    services.AddQAProcessorApplication(
        configuration.GetSection("ApplicationSettings"));

    if (environment.IsDevelopment() || environment.IsEnvironment("TestLocal"))
    {
        services.AddJsonFileReferralOutput(
            configuration.GetSection("ReferralOutput:JsonFile"));

        services.AddLocalFileStorage(
            configuration.GetSection("FileStorage:Local"));
    }
    else
    {
        services.AddVoxJarApiClient(
            clientConfig: configuration.GetSection("VoxJarApiClient"),
            authConfig: configuration.GetSection("VoxJarApiClient:Authentication"));

        services.AddVoxJarReferralOutput(configuration.GetSection("ReferralOutput:VoxJar"));
    }

    services.AddStatTracApiReferralSource();
}

