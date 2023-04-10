using Emailer.LegacyBridge.App;
using Emailer.LegacyBridge.Infrastructure.EmailMessageQueue.LegacyQueue;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Statline.Common.Services;
using Statline.Common.Utilities;

namespace Emailer.LegacyBridge.Infrastructure.EmailMessageQueue
{
    public static class ServiceCollectionExtensions
    {
        public static void AddLegacyEmailMessageQueue(
            this IServiceCollection services,
            IConfiguration config,
            string dbSettingsPath)
        {
            Check.NotNull(services, nameof(services));
            Check.NotNull(config, nameof(config));
            Check.NotNull(dbSettingsPath, nameof(dbSettingsPath));

            services.AddDbContext<ReferralDbContext>(
                (o) => o.ConfigureSqlServerDbContext(config, dbSettingsPath));
            services.AddTransient<ILegacyMessageQueue, LegacyMessageQueue>();
            services.AddTransient<IEmailMessageQueue, EmailMessageQueueAdapter>();
            services.AddSingleton<IDateTimeService, DateTimeService>();
        }
    }
}
