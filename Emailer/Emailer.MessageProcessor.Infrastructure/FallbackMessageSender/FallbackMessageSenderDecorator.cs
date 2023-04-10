using Emailer.MessageProcessor.Domain;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Statline.Common.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace Emailer.MessageProcessor.Infrastructure.FallbackMessageSender
{
    public class FallbackMessageSenderDecorator : IEmailMessageSenderService
    {
        private readonly IEmailMessageSenderService childMessageSender;
        private readonly ILogger logger;
        private readonly FallbackMessageSenderDecoratorOptions options;

        public FallbackMessageSenderDecorator(
            IEmailMessageSenderService childMessageSender,
            IOptions<FallbackMessageSenderDecoratorOptions> options,
            ILogger<FallbackMessageSenderDecorator> logger)
        {
            Check.NotNull(childMessageSender, nameof(childMessageSender));
            Check.NotNull(logger, nameof(logger));
            Check.NotNull(options, nameof(options));

            this.childMessageSender = childMessageSender;
            this.logger = logger;
            this.options = options.Value;
        }

        public async Task SendMessageAsync(EmailMessage message, CancellationToken cancellationToken)
        {
            try
            {
                await childMessageSender.SendMessageAsync(message, cancellationToken).ConfigureAwait(false);
            }
            catch (Exception ex)
            {
                logger.LogMessageSendingFailed(ex, message);
                await SendFallbackMessage(message, cancellationToken).ConfigureAwait(false);
            }
        }

        private async Task SendFallbackMessage(EmailMessage originalMessage, CancellationToken cancellationToken)
        {
            var fallbackMessage = BuildFallbackMessage(originalMessage);
            await childMessageSender.SendMessageAsync(fallbackMessage, cancellationToken).ConfigureAwait(false);
        }

        private EmailMessage BuildFallbackMessage(EmailMessage originalMessage)
        {
            var emailBody = BuildFallbackMessageBody(originalMessage);

            return new EmailMessageBuilder()
                .SetMessageId(originalMessage.Id)
                .SetBody(emailBody)
                .SetFromAddress(originalMessage.From)
                .SetToAddresses(options.ToEmails.Select(addr => new EmailAddress(addr)))
                .SetSubject(options.EmailSubject ?? string.Empty)
                .Build();
        }

        public static string BuildFallbackMessageBody(EmailMessage originalMessage)
        {
            var errorTextBody = new StringBuilder();

            errorTextBody.AppendLine("*** Send text page/email before calling IT support. ***");
            errorTextBody.AppendLine();
            errorTextBody.AppendLine("The following page/email was not sent because attempt to send failed:");
            errorTextBody.AppendLine();
            errorTextBody.AppendFormat("ID: {0}", originalMessage.Id);
            errorTextBody.AppendLine();
            errorTextBody.AppendFormat("To: {0}", FormatToString(originalMessage.To));
            errorTextBody.AppendLine();
            errorTextBody.AppendFormat("Cc: {0}", FormatToString(originalMessage.CC));
            errorTextBody.AppendLine();
            errorTextBody.AppendFormat("Bcc: {0}", FormatToString(originalMessage.Bcc));
            errorTextBody.AppendLine();
            errorTextBody.AppendFormat("From: {0}", originalMessage.From);
            errorTextBody.AppendLine();
            errorTextBody.AppendFormat("Subject: {0}", originalMessage.Subject);
            errorTextBody.AppendLine();
            errorTextBody.AppendLine("Email Body: ");
            errorTextBody.Append(originalMessage.Body);

            return errorTextBody.ToString();
        }

        private static string FormatToString(IEnumerable<EmailAddress> emailAddresses)
        {
            return string.Join(";", emailAddresses);
        }
    }
}
