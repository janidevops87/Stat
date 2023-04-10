using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Statline.StatTrac.BusinessVeracity.Common.Application;

namespace Statline.StatTrac.BusinessVeracity.QAProcessor.Application;

public static class ServiceCollectionExtensions
{
    public static void AddQAProcessorApplication(
        this IServiceCollection services,
        IConfiguration configuration)
    {
        services.ConfigureWithDataAnnotationValidation<QAProcessorApplicationOptions>(configuration);
        services.AddTransient<IReferralProcessorApplication, QAProcessorApplication>();
    }
}
