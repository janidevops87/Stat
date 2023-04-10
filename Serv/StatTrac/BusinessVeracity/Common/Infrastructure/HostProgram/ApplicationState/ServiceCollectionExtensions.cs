using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace Statline.StatTrac.BusinessVeracity.Common.Infrastructure.HostProgram.ApplicationState;

public static class ServiceCollectionExtensions
{
    public static void AddJsonFileApplicationStateStorage(
        this IServiceCollection services,
        IConfiguration configuration)
    {
        Check.NotNull(services, nameof(services));
        Check.NotNull(configuration, nameof(configuration));

        services.AddTransient(typeof(IApplicationStateStorage<>), typeof(JsonFileApplicationStateStorage<>));
        services.ConfigureWithDataAnnotationValidation<JsonFileApplicationStateStorageOptions>(configuration);
    }
}
