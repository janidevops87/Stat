using Microsoft.Extensions.DependencyInjection;
using Statline.Common.Utilities;

namespace Emailer.LegacyBridge.App
{
    public static class ServiceCollectionExtensions
    {
        public static void AddMessageForwardingApp(
           this IServiceCollection services)
        {
            Check.NotNull(services, nameof(services));

            services.AddScoped<MessageForwardingApp>();
        }
    }
}
