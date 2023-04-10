using System;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Statline.Common.Utilities;

namespace Statline.Common.AppModel.Host
{
    public static class AppHostBuilderExtensions
    {
        public static IAppHostBuilder ConfigureAppConfiguration(
            this IAppHostBuilder hostBuilder,
            Action<IConfigurationBuilder> configureDelegate)
        {
            Check.NotNull(hostBuilder, nameof(hostBuilder));

            return hostBuilder.ConfigureAppConfiguration(
                (_, builder) => configureDelegate(builder));
        }

        public static IAppHostBuilder ConfigureServices(
            this IAppHostBuilder hostBuilder,
            Action<IServiceCollection> configureServices)
        {
            Check.NotNull(hostBuilder, nameof(hostBuilder));

            return hostBuilder.ConfigureServices(
                (_, services) => configureServices(services));
        }

        public static IAppHostBuilder ConfigureLogging(
            this IAppHostBuilder hostBuilder, 
            Action<ILoggingBuilder> configureLogging)
        {
            Check.NotNull(hostBuilder, nameof(hostBuilder));

            return hostBuilder.ConfigureServices(
                collection => collection.AddLogging(configureLogging));
        }

        public static IAppHostBuilder ConfigureLogging(
            this IAppHostBuilder hostBuilder, 
            Action<AppHostBuilderContext, ILoggingBuilder> configureLogging)
        {
            Check.NotNull(hostBuilder, nameof(hostBuilder));
            Check.NotNull(configureLogging, nameof(configureLogging));

            return hostBuilder.ConfigureServices(
                (context, collection) => collection.AddLogging(
                    builder => configureLogging(context, builder)));
        }
    }
}
