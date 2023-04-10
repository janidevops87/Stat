using Emailer.MessageProcessor.Domain;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;

namespace Emailer.MessageProcessor.Infrastructure.FallbackMessageSender
{
    internal static class LoggerExtensions
    {
        public static void LogMessageSendingFailed(
            this ILogger logger,
            Exception exception,
            EmailMessage message)
        {
            logger.LogError(
                      exception: exception,
                     "Failed to send a message with id '{Id}', To adresses '{ToAddresses}', " +
                     "CC addresses '{CcAddresses}', Bcc addresses '{BccAddresses}', " +
                     "From address '{FromAddress}'. " +
                     "Trying to send an error notification as a fallback action.", 
                     message.Id,
                     message.To.FormatToString(),
                     message.CC.FormatToString(),
                     message.Bcc.FormatToString(),
                     message.From);
        }

        private static string FormatToString(
            this IEnumerable<EmailAddress> emailAddresses)
        {
            return string.Join(";", emailAddresses);
        }
    }
}
