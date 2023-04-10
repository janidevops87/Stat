using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Statline.StatTrac.BusinessVeracity.Common.Application;
using Statline.StatTrac.BusinessVeracity.QAProcessor.Application;

namespace Statline.StatTrac.BusinessVeracity.QAProcessor.Infrastructure.ReferralOutput.VoxJar;

public static class ServiceCollectionExtensions
{
    public static void AddVoxJarReferralOutput(
        this IServiceCollection services,
        IConfiguration configuration)
    {
        services.AddTransient<IReferralOutput<HighRiskReferralMetadata>, VoxJarReferralOutput>();
        services.ConfigureWithDataAnnotationValidation<VoxJarReferralOutputOptions>(configuration);
    }
}
