using System;
using Microsoft.Extensions.Configuration;
using Statline.Common.Utilities;

namespace Statline.Common.Configuration.Email.Sender
{
    public static class ConfigurationExtensions
    {
        public static EmailSenderSettings GetEmailSenderSettings(
           this IConfiguration config,
           string settingsPath)
        {
            Check.NotNull(config, nameof(config));
            Check.NotEmpty(settingsPath, nameof(settingsPath));

            var settings = new EmailSenderSettings();
            config.FillEmailSenderSettings(settingsPath, settings);

            return settings;
        }

        internal static void FillEmailSenderSettings(
            this IConfiguration config,
            string settingsPath,
            EmailSenderSettings settingsInstance)
        {
            var settings = config.GetSection(settingsPath).Get<EmailSenderSettingsRaw>();

            if (settings == null)
            {
                throw new ArgumentException(
                    $"Settings were not found at path '{settingsPath}'.",
                    nameof(settingsPath));
            }

            var smptpServerSettings =
                settings.SmtpServerSettingsReference.GetValue(config);

            settingsInstance.SmtpServerSettings = smptpServerSettings;
            settingsInstance.EmailSubject = settings.EmailSubject;
            settingsInstance.FromEmail = settings.FromEmail;
            settingsInstance.ToEmails = settings.ToEmails;
        }
    }
}
