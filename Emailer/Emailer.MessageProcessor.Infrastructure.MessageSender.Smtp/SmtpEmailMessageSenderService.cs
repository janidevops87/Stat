using Emailer.MessageProcessor.Domain;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Statline.Common.Configuration.Email.Sender;
using Statline.Common.Configuration.Email.Smtp;
using System;
using System.Net.Mail;
using System.Threading;
using System.Threading.Tasks;

namespace Emailer.MessageProcessor.Infrastructure.MessageSender.Smtp
{
    public class SmtpEmailMessageSenderService : IEmailMessageSenderService
    {
        private readonly IOptions<EmailSenderSettings> options;
        private readonly ILogger logger;

        public SmtpEmailMessageSenderService(
            IOptions<EmailSenderSettings> options,
            ILogger<SmtpEmailMessageSenderService> logger)
        {
            this.options = options;
            this.logger = logger;
        }

        public async Task SendMessageAsync(EmailMessage message, CancellationToken cancellationToken)
        {
            if (message == null)
            {
                throw new ArgumentNullException(nameof(message));
            }

            var mailMessage = message.ToMailMessage();
            var options = this.options.Value;

            if (options.FromEmail is not null)
            {
                // This uses the from address DisplayName passed in as the 
                // "friendly name" but actually sends
                // from the options.FromEmail address.
                mailMessage.From = new MailAddress(
                    options.FromEmail,
                    message.From.DisplayName);
            }

            logger.LogInformation("Sending email message with id = '{Id}' to: '{ToAddresses}'",
                message.Id,
                mailMessage.To);

            try
            {
                await SendMessageAsync(mailMessage);
            }
            catch (Exception ex)
            {
                logger.LogError(
                    eventId: 0,
                    exception: ex,
                    message: "Error sending email message with id = '{Id}' to: '{ToAddresses}'",
                    message.Id, mailMessage.To);
                throw;
            }

            logger.LogInformation("Email message with id = '{Id}' sent.", message.Id);
        }

        private async Task SendMessageAsync(MailMessage mailMessage)
        {
            var options = this.options.Value;

            var smtpSettings = options.SmtpServerSettings;

            // Beware that disposing SmtpClient results in synchronous IO (scalability problems?).
            using var smtp = new SmtpClient();

            smtp.Host = smtpSettings.ServerName;
            smtp.Port = smtpSettings.ServerPort;
            smtp.EnableSsl = smtpSettings.SecureConnectionMode != SecureSocketOptions.None;
            smtp.Credentials = smtpSettings.Credential;

            // TODO: Implement cancellation token support 
            // (SmtpClient doesn't support it natively).
            await smtp.SendMailAsync(mailMessage).ConfigureAwait(false);
        }
    }
}
