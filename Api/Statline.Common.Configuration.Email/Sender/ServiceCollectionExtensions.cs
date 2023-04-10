using Microsoft.Extensions.Configuration;
using Statline.Common.Configuration.Email.Sender;
using Statline.Common.Utilities;

namespace Microsoft.Extensions.DependencyInjection
{
    public static class ServiceCollectionExtensions
    {
        public static void ConfigureEmailSenderSettingsOptions(
            this IServiceCollection services,
            IConfiguration config,
            string settingsPath)
        {
            Check.NotNull(services, nameof(services));
            Check.NotNull(config, nameof(config));
            Check.NotEmpty(settingsPath, nameof(settingsPath));

            services.Configure<EmailSenderSettings>(
                settings => config.FillEmailSenderSettings(settingsPath, settings));
        }
    }
}
