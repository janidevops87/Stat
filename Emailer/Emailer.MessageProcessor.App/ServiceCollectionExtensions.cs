using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Statline.Common.Utilities;

namespace Emailer.MessageProcessor.App
{
    public static class ServiceCollectionExtensions
    {
        public static void AddMessageProcessorApp(
           this IServiceCollection services,
           IConfiguration config)
        {
            Check.NotNull(services, nameof(services));
            Check.NotNull(config, nameof(config));

            services.Configure<MessageProcessorAppOptions>(config);
            services.AddTransient<MessageProcessorApp>();
        }
    }
}
