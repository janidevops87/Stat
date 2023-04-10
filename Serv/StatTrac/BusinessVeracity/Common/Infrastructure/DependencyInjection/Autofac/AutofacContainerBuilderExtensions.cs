using Autofac.Builder;
using Autofac.Extensions.DependencyInjection;
using Autofac.Features.OpenGenerics;
using Microsoft.Extensions.DependencyInjection;
using System.Collections.Concurrent;

namespace Autofac;

public static class AutofacContainerBuilderExtensions
{
    private static readonly ConcurrentDictionary<Type, ObjectFactory> FactoryCache = new();

    /// <summary>
    /// Registers an open generic service implementation bound to a named <typeparamref name="TOptions"/>
    /// instance.
    /// </summary>
    /// <dev>
    /// The in-box DI (IServiceProvider) doesn't support registering open generics
    /// with a factory delegate which accepts generic type parameters among arguments.
    /// This makes manual open generic object instantiation impossible (as we need to 
    /// make it a closed generic type first).
    /// But Autofac does provide the type parameters to the delegate factory. Thus, using Autofac.
    /// </dev>
    public static IRegistrationBuilder<object, OpenGenericDelegateActivatorData, DynamicRegistrationStyle>
        RegisterGenericWithNamedOptions<TOptions>(
            this ContainerBuilder containerBuilder,
            Type implementationType,
            string optionsName)
        where TOptions : class, new()
    {
        Check.NotNull(containerBuilder, nameof(containerBuilder));
        Check.NotNull(implementationType, nameof(implementationType));
        Check.NotEmpty(optionsName, nameof(optionsName));

        return containerBuilder.RegisterGeneric((context, types, parameters) =>
        {
            var closedGenericType = implementationType.MakeGenericType(types);

            var factory = FactoryCache.GetOrAdd(closedGenericType, type =>
                ActivatorUtilities.CreateFactory(type, new[] { typeof(IOptions<TOptions>) }));

            var options = context.GetNamedOptions<TOptions>(optionsName);

            var serviceProvider = context.Resolve<IServiceProvider>();

            return factory(serviceProvider, new[] { options });
        });
    }

    /// <summary>
    /// Populates container builder with services added to
    /// a <see cref="IServiceCollection"/> in the provided callback.
    /// </summary>
    /// <param name="containerBuilder">
    /// The container builder.
    /// </param>
    /// <param name="configureServices">
    /// The callback to add services to a <see cref="IServiceCollection"/>.
    /// </param>
    public static void PopulateFromServices(
            this ContainerBuilder containerBuilder,
            Action<IServiceCollection> configureServices)
    {
        Check.NotNull(containerBuilder, nameof(containerBuilder));
        Check.NotNull(configureServices, nameof(configureServices));

        var services = new ServiceCollection();
        configureServices(services);
        containerBuilder.Populate(services);
    }

    private static IOptions<TOptions> GetNamedOptions<TOptions>(
        this IComponentContext context,
        string optionsName)
        where TOptions : class, new()
    {
        var optionsMonitor = context.Resolve<IOptionsMonitor<TOptions>>();

        var namedOptions = optionsMonitor.Get(optionsName);

        return Options.Create(namedOptions);
    }
}
