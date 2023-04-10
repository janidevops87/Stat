using System;
using Statline.Common.Configuration.Email.Smtp;
using Statline.Common.Utilities;

namespace Microsoft.Extensions.Configuration
{
    public static class ConfigurationExtensions
    {
        public static SmtpServerSettings GetSmtpServerSettings(
            this IConfiguration configuration)
        {
            Check.NotNull(configuration, nameof(configuration));

            var settings = configuration.Get<SmtpServerSettings>();

            if (settings == null)
            {
                throw new ArgumentException(
                    $"SMTP server settings were not found " +
                    $"in provided configuration.",
                    nameof(configuration));
            }

            settings.Validate(nameof(settings));

            return settings;
        }
    }
}