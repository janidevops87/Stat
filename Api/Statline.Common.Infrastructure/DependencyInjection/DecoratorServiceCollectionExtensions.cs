using Microsoft.Extensions.DependencyInjection;
using Statline.Common.Utilities;
using System;
using System.Collections.Generic;

namespace Microsoft.Extensions.DependencyInjection
{
    public static class DecoratorServiceCollectionExtensions
    {
        public static void AddDecoratorTransient<TService, TImplementation>(
            this IServiceCollection serviceCollection,
            Action<IServiceCollection> configureChildServices)
                where TImplementation : class, TService
                where TService : class
        {
            Check.NotNull(serviceCollection, nameof(serviceCollection));

            serviceCollection.AddDecorator<TService, TImplementation>(
                configureChildServices,
                (implementationFactory, services) => services.AddTransient(implementationFactory));
        }

        public static void AddDecoratorSingleton<TService, TImplementation>(
            this IServiceCollection serviceCollection,
            Action<IServiceCollection> configureChildServices)
                where TImplementation : class, TService
                where TService : class
        {
            Check.NotNull(serviceCollection, nameof(serviceCollection));

            serviceCollection.AddDecorator<TService, TImplementation>(
                configureChildServices,
                (implementationFactory, services) => services.AddSingleton(
                    (Func<IServiceProvider, TService>)implementationFactory));
        }

        public static void AddDecoratorScoped<TService, TImplementation>(
            this IServiceCollection serviceCollection,
            Action<IServiceCollection> configureChildServices)
                where TImplementation : class, TService
                where TService : class
        {
            Check.NotNull(serviceCollection, nameof(serviceCollection));

            serviceCollection.AddDecorator<TService, TImplementation>(
                configureChildServices,
                (implementationFactory, services) => services.AddScoped(implementationFactory));
        }

        public static void AddDecorator<TService, TImplementation>(
            this IServiceCollection serviceCollection,
            Action<IServiceCollection> configureChildServices,
            Action<Func<IServiceProvider, TService>, IServiceCollection> configureDecorator)
                where TImplementation : class, TService
                where TService : class
        {
            serviceCollection.AddDecorator<TService, TImplementation>(
                configureChildServices,
                (childServicesProvider, services) =>
                    configureDecorator(
                        _ => ActivatorUtilities.CreateInstance<TImplementation>(childServicesProvider),
                        services));
        }

        public static void AddDecorator<TService, TImplementation>(
            this IServiceCollection serviceCollection,
            Action<IServiceCollection> configureChildServices,
            Action<IServiceProvider, IServiceCollection> configureDecorator)
                where TImplementation : class, TService
                where TService : class
        {
            Check.NotNull(serviceCollection, nameof(serviceCollection));
            Check.NotNull(configureChildServices, nameof(configureChildServices));
            Check.NotNull(configureDecorator, nameof(configureDecorator));

            // The idea of the below is to create kind of
            // a DI "sandbox" so each decorator's dependency can 
            // be configured with existing service collection extension
            // methods or familiar services registration. After that, 
            // we can use created service provider to
            // resolve decorator's dependencies. 
            var childServiceCollection = new ServiceCollection { serviceCollection };

            configureChildServices(childServiceCollection);

            var childServicesProvider = childServiceCollection.BuildServiceProvider();

            configureDecorator(childServicesProvider, serviceCollection);
        }
    }
}
