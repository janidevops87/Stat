using Microsoft.Extensions.DependencyInjection;
using Statline.StatTrac.BusinessVeracity.Common.Application.CallInformation;

namespace Statline.StatTrac.BusinessVeracity.Common.Infrastructure.CallInformation.InContactPreloaded;

public static class ServiceCollectionExtensions
{
    public static void AddInContactPreloadedCallInformationProvider(
        this IServiceCollection services)
    {
        services.AddTransient<ICallInformationProvider, InContactPreloadedCallInformationProvider>();
    }
}
