using Statline.Common.Services.Email.Abstractions;

namespace Emailer.MessageProcessor.Infrastructure.MessageSender.EmailService;

internal static class EmailMessageExtensions
{
    public static EmailMessage ToEmailServiceMessage(
        this Domain.EmailMessage emailMessage, 
        string? fromEmailOverride)
    {
        EmailAddress fromAddress;

        if (fromEmailOverride is not null)
        {
            // This uses the from address DisplayName passed in as the 
            // "friendly name" but actually sends
            // from the fromEmailOverride address.
            fromAddress = new EmailAddress(
                fromEmailOverride,
                emailMessage.From.DisplayName);
        }
        else
        {
            fromAddress = emailMessage.From.ToEmailServiceAddress();
        }

        var mailMessage = new EmailMessage(
            fromAddress,
            toAddresses: emailMessage.To.ToEmailServiceAddresses().ToArray(),
            content: new StringEmailContent(emailMessage.Body, isHtml: false),
            subject: emailMessage.Subject);

        return mailMessage;
    }
}
