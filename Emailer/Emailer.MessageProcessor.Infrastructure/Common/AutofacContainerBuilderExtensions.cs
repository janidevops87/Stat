using Autofac;
using Autofac.Extensions.DependencyInjection;
using Microsoft.Extensions.DependencyInjection;
using System;

namespace Emailer.MessageProcessor.Infrastructure.Common
{
    // TODO: Move this to a common project.
    internal static class AutofacContainerBuilderExtensions
    {
        public static void PopulateFromServices(
            this ContainerBuilder containerBuilder,
            Action<IServiceCollection> configureServices)
        {
            var services = new ServiceCollection();
            configureServices(services);
            containerBuilder.Populate(services);
        }
    }

}
