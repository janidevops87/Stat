using System;
using System.Collections.Generic;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Statline.Common.AppModel.Environment;
using Statline.Common.Utilities;

namespace Statline.Common.AppModel.Host
{
    public class AppHostBuilder : IAppHostBuilder
    {
        private const string EnvironmentVariablesPrefix = "NETCORE_";

        private readonly List<Action<AppHostBuilderContext, IServiceCollection>>
            configureServicesDelegates = new List<Action<AppHostBuilderContext, IServiceCollection>>();

        private readonly List<Action<AppHostBuilderContext, IConfigurationBuilder>>
            configureAppConfigurationBuilderDelegates = new List<Action<AppHostBuilderContext, IConfigurationBuilder>>();

        private readonly IConfiguration config;
        private readonly AppHostBuilderContext context;

        public AppHostBuilder()
        {
            // Build a basic configuration based on environment 
            // variables to start with.
            config = new ConfigurationBuilder()
                .AddEnvironmentVariables(prefix: EnvironmentVariablesPrefix)
                .Build();

            context = new AppHostBuilderContext
            {
                Configuration = config
            };
        }

        public IAppHost Build()
        {
            var hostingServices = BuildCommonServices();
            var applicationServices = new ServiceCollection { hostingServices };
            var hostingServiceProvider = hostingServices.BuildServiceProvider();

            return new AppHost(
                applicationServices,
                hostingServiceProvider,
                config);
        }

        public IAppHostBuilder ConfigureAppConfiguration(
            Action<AppHostBuilderContext, IConfigurationBuilder> configureDelegate)
        {
            Check.NotNull(configureDelegate, nameof(configureDelegate));

            configureAppConfigurationBuilderDelegates.Add(configureDelegate);

            return this;
        }

        public IAppHostBuilder ConfigureServices(
            Action<AppHostBuilderContext, IServiceCollection> configureServices)
        {
            Check.NotNull(configureServices, nameof(configureServices));

            configureServicesDelegates.Add(configureServices);

            return this;
        }

        private IServiceCollection BuildCommonServices()
        {
            var services = new ServiceCollection();

            var environment = BuildEnvironment();

            context.HostingEnvironment = environment;

            services.AddSingleton(environment);
            services.AddSingleton(context);

            var builder = new ConfigurationBuilder()
                .AddInMemoryCollection(config.AsEnumerable());


            foreach (var configureAppConfiguration in configureAppConfigurationBuilderDelegates)
            {
                configureAppConfiguration(context, builder);
            }

            var configuration = builder.Build();

            services.AddSingleton<IConfiguration>(configuration);

            context.Configuration = configuration;

            foreach (var configureServices in configureServicesDelegates)
            {
                configureServices(context, services);
            }

            return services;
        }

        private IEnvironment BuildEnvironment()
        {
            var environmentVariableSource =
                new ConfigurationEnvironmentVariableSource(config);

            return new Environment.Environment(environmentVariableSource);
        }
    }
}
