using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace Statline.StatTracUploader.App.Processor
{
    public static class ServiceCollectionExtentions
    {
        public static void AddPendingReferralsProcessorApp(
            this IServiceCollection services,
            IConfiguration config)
        {
            services.Configure<PendingReferralsProcessorAppOptions>(config);
            services.AddScoped<PendingReferralsProcessorApp>();
        }
    }
}
