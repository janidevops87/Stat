
using Statline.Common.Services.Email.Abstractions;

namespace Emailer.MessageProcessor.Infrastructure.MessageSender.EmailService;

internal static class EmailAddressExtensions
{
    public static EmailAddress ToEmailServiceAddress(
        this Domain.EmailAddress emailAddress)
    {
        return new EmailAddress(emailAddress.Address, emailAddress.DisplayName);
    }

    public static IEnumerable<EmailAddress> ToEmailServiceAddresses(
        this IEnumerable<Domain.EmailAddress> emailAddresses)
    {
        return emailAddresses.Select(ToEmailServiceAddress);
    }
}
