using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace Statline.StatTrac.BusinessVeracity.Common.Infrastructure.FileStorage.Local;

public static class ServiceCollectionExtensions
{
    public static void AddLocalFileStorage(
        this IServiceCollection services,
        IConfiguration configuration)
    {
        services.AddScoped<IFileStorage, LocalFileStorage>();
        services.ConfigureWithDataAnnotationValidation<LocalFileStorageOptions>(configuration);
    }
}
