using Serilog.Sinks.Email;
using Statline.Common.Configuration.Email.Sender;
using System;
using System.Linq;
using System.Net;
using System.Reflection;
using System.Runtime.Versioning;

namespace Statline.Extensions.Logging.Email
{
    internal static class EmailLoggerSettingsExtensions
    {
        public static EmailConnectionInfo ToSerilogEmailConnectionInfo(
            this EmailSenderSettings emailSenderSettings)
        {
            var smtpSettings = emailSenderSettings.SmtpServerSettings;

            return new EmailConnectionInfo
            {
                FromEmail = emailSenderSettings.FromEmail,
                ToEmail = emailSenderSettings.ToEmails,
                EmailSubject = emailSenderSettings.EmailSubject,
                NetworkCredentials = new NetworkCredential(
                            smtpSettings.Credential.UserName,
                            smtpSettings.Credential.Password),
                MailServer = smtpSettings.ServerName,
                Port = smtpSettings.ServerPort,
                // This means not what you might think.
                // Setting this flag to true actually forces SSL 
                // instead of TLS in case of MailKit implementation.
                // For details see https://github.com/serilog/serilog-sinks-email/issues/42.
                // So we're trying to detect which implementation
                // is used and choose correct flag value.
                // This is a hack and should be removed
                // once the library receives bug fix.
                EnableSsl = !IsMailKitImplementation()
            };
        }

        private static bool IsMailKitImplementation()
        {
            // We know that MailKit implementation is used in .Net Standard
            // package, and .Net Framework package uses System.Net.Mail.
            var implAssembly = typeof(EmailConnectionInfo).Assembly;
            return IsNetStandardAssembly(implAssembly);
        }

        private static bool IsNetStandardAssembly(Assembly assembly)
        {
            var targetFrameworkAttr = (TargetFrameworkAttribute)assembly.GetCustomAttributes(
                typeof(TargetFrameworkAttribute), false).First();

            var name = new FrameworkName(targetFrameworkAttr.FrameworkName);

            bool containsNetStandardTfm = name.Identifier.IndexOf(
                    "netstandard", 
                    StringComparison.OrdinalIgnoreCase) != -1;

            return containsNetStandardTfm;
        }
    }
}
