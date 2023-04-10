using Emailer.MessageProcessor.Domain;
using System;
using System.Linq;
using System.Net.Mail;

namespace Emailer.MessageProcessor.App
{
    internal static class EmailMessageInfoExtensions
    {
        public static EmailMessageBuilder ToEmailMessageBuilder(
            this EmailMessageInfo emailMessage)
        {
            return new EmailMessageBuilder()
                .SetMessageId(emailMessage.Id)
                .SetFromAddress(ParseAddress(emailMessage.From) ??
                    throw new InvalidOperationException($"The From address contains an invalid email address '{emailMessage.From}'"))
                .SetToAddresses(ParseManyAddresses(emailMessage.To))
                .SetCcAddresses(ParseManyAddresses(emailMessage.CC))
                .SetBccAddresses(ParseManyAddresses(emailMessage.Bcc))
                .SetSubject(emailMessage.Subject ?? string.Empty)
                .SetBody(emailMessage.Body ?? string.Empty)
                .Validate();
        }

        public static EmailMessage ToEmailMessage(this EmailMessageInfo emailMessage)
        {
            return emailMessage.ToEmailMessageBuilder().Build();
        }

        private static EmailAddress[] ParseManyAddresses(string? addresses)
        {
            if (addresses is null || addresses.Length == 0)
            {
                return Array.Empty<EmailAddress>();
            }

            // Parsing and validation multiple addresses.
            var parsedAddresses = new MailAddressCollection();
            parsedAddresses.Add(addresses);

            return parsedAddresses
                .Select(addr => new EmailAddress(addr.Address, addr.DisplayName))
                .ToArray();
        }

        private static EmailAddress? ParseAddress(string? address)
        {
            if (address is null)
            {
                return null;
            }

            // Parsing and validation.
            var parsedAddress = new MailAddress(address);

            return new EmailAddress(parsedAddress.Address, parsedAddress.DisplayName);
        }
    }
}
