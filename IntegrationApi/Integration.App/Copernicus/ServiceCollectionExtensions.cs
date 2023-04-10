using Microsoft.Extensions.DependencyInjection;

namespace Statline.StatTrac.Integration.App.Copernicus;

public static class ServiceCollectionExtensions
{
    public static void AddCopernicusApp(
        this IServiceCollection services)
    {
        services.AddTransient<CopernicusApp>();
    }
}
