using Emailer.MessageProcessor.Domain;
using System.Collections.Generic;
using System.Net.Mail;

namespace Emailer.MessageProcessor.Infrastructure.MessageSender.Smtp
{
    internal static class EmailMessageExtensions
    {
        public static MailMessage ToMailMessage(this EmailMessage emailMessage)
        {
            var mailMessage = new MailMessage
            {
                To = { emailMessage.To.ToMailAddresses() },
                CC = { emailMessage.CC.ToMailAddresses() },
                Bcc = { emailMessage.Bcc.ToMailAddresses() },
                From = emailMessage.From.ToMailAddress(),
                Subject = emailMessage.Subject,
                Body = emailMessage.Body
            };

            return mailMessage;
        }
    }
}
