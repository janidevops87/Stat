using Emailer.MessageProcessor.Domain;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;

namespace Emailer.MessageProcessor.Infrastructure.MessageSender.Smtp
{
    internal static class EmailAddressExtensions
    {
        public static MailAddress ToMailAddress(this EmailAddress emailAddress)
        {
            return new MailAddress(emailAddress.Address, emailAddress.DisplayName);
        }

        public static IEnumerable<MailAddress> ToMailAddresses(this IEnumerable<EmailAddress> emailAddresses)
        {
            return emailAddresses.Select(ToMailAddress);
        }
    }
}
