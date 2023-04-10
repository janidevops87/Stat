using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Statline.StatTrac.BusinessVeracity.Common.Application;

namespace Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ReferralOutput.JsonFile;

public static class ServiceCollectionExtensions
{
    public static void AddJsonFileReferralOutput(
        this IServiceCollection services,
        IConfiguration configuration)
    {
        services.AddTransient(
            typeof(IReferralOutput<>),
            typeof(JsonFileReferralOutput<>));

        services.ConfigureWithDataAnnotationValidation<JsonFileReferralOutputOptions>(configuration);
    }
}
