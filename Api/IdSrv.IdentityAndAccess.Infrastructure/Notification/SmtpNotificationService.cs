using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Statline.Common.Configuration.Email.Sender;
using Statline.Common.Configuration.Email.Smtp;
using Statline.Common.Utilities;
using Statline.IdentityServer.IdentityAndAccess.App.Common;
using System.Net.Mail;
using System.Threading.Tasks;

namespace Statline.IdentityServer.IdentityAndAccess.Infrastructure.Notification
{
    public class SmtpNotificationService : INotificationService
    {
        private readonly EmailSenderSettings settings;
        private readonly ILogger logger;

        public SmtpNotificationService(
            IOptions<EmailSenderSettings> options,
            ILogger<SmtpNotificationService> logger)
        {
            Check.NotNull(options, nameof(options));
            Check.NotNull(logger, nameof(logger));
            this.settings = options.Value;
            this.logger = logger;
        }

        public async Task SendNotificationAsync(string toAddress, string message, string subject)
        {
            logger.LogInformation("Sending notification over SMTP to '{address}'.", toAddress);

            MailMessage msg = new MailMessage()
            {
                Subject = subject,
                From = new MailAddress(settings.FromEmail),
                Body = string.Format(message, toAddress)
            };

            msg.To.Add(new MailAddress(toAddress));
            msg.IsBodyHtml = true;

            var smtpSettings = settings.SmtpServerSettings;

            // NOTE: Disposing makes blocking synchronous IO.
            using (var smtp = new SmtpClient())
            {
                smtp.Host = smtpSettings.ServerName;
                smtp.Port = smtpSettings.ServerPort;
                smtp.EnableSsl = smtpSettings.SecureConnectionMode != SecureSocketOptions.None;
                smtp.Credentials = smtpSettings.Credential;

                await smtp.SendMailAsync(msg).ConfigureAwait(false);
            }
        }
    }
}
