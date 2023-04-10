using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Statline.StatTrac.BusinessVeracity.Common.Infrastructure.FileStorage;

namespace Statline.StatTrac.BusinessVeracity.EodProcessor.Infrastructure.FileStorage.AmazonS3;

internal static class ServiceCollectionExtensions
{
    public static void AddAmazonS3FileStorage(
        this IServiceCollection services,
        IConfiguration configuration)
    {
        services.AddTransient<IFileStorage, AmazonS3FileStorage>();
        services.ConfigureWithDataAnnotationValidation<AmazonS3FileStorageOptions>(configuration);
    }
}
