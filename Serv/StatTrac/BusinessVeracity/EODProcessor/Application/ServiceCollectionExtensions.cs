using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Statline.StatTrac.BusinessVeracity.Common.Application;

namespace Statline.StatTrac.BusinessVeracity.EodProcessor.Application;

public static class ServiceCollectionExtensions
{
    public static void AddEodProcessorApplication(
        this IServiceCollection services,
        IConfiguration configuration)
    {
        services.ConfigureWithDataAnnotationValidation<EodProcessorApplicationOptions>(configuration);
        services.AddTransient<IReferralProcessorApplication, EodProcessorApplication>();
    }
}
