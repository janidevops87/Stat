using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Statline.Common.Utilities;
using Statline.StatTracUploader.App.Common.Notification;

namespace Statline.StatTracUploader.Infrastructure.Services.Notification.MailKit
{
    public static class ServiceCollectionExtensions
    {
        public static void AddMailKitNotificationService(
            this IServiceCollection services,
            IConfiguration rootConfig,
            string settingsPath)
        {
            Check.NotNull(services, nameof(services));
            Check.NotNull(rootConfig, nameof(rootConfig));

            services.ConfigureEmailSenderSettingsOptions(rootConfig, settingsPath);
            services.AddSingleton<INotificationService, MailKitNotificationService>();
        }
    }
}
