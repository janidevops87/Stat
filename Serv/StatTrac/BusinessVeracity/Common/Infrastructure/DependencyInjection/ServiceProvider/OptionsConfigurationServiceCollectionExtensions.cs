using Microsoft.Extensions.Configuration;
using Statline.Common.Utilities;

namespace Microsoft.Extensions.DependencyInjection;

public static class OptionsConfigurationServiceCollectionExtensions
{
    public static IServiceCollection ConfigureWithDataAnnotationValidation<TOptions>(
        this IServiceCollection services, 
        IConfiguration config) where TOptions : class
    {
        Check.NotNull(services, nameof(services));

        services
            .AddOptions<TOptions>()
            .ValidateDataAnnotations()
            .Bind(config);

        return services;
    }

    public static IServiceCollection ConfigureWithDataAnnotationValidation<TOptions>(
       this IServiceCollection services,
       IConfiguration config,
       string optionsName) where TOptions : class
    {
        Check.NotNull(services, nameof(services));
        Check.NotEmpty(optionsName, nameof(optionsName));

        services
            .AddOptions<TOptions>(optionsName)
            .ValidateDataAnnotations()
            .Bind(config);

        return services;
    }
}
