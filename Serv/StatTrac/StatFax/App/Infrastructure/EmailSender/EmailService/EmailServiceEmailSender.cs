#nullable enable

using Statline.Common.Services.Email.Abstractions;
using Statline.Common.Utilities;
using Statline.StatTrac.StatFax.Application.EmailSender;

namespace Statline.StatTrac.StatFax.Infrastructure.EmailSender.EmailService;

/// <summary>
/// This implementation of <see cref="IEmailSender"/> works like an adapter
/// for <see cref="IEmailService"/>.
/// </summary>
public class EmailServiceEmailSender : IEmailSender
{
    private readonly IEmailService emailService;
    private readonly EmailServiceEmailSenderOptions options;

    public EmailServiceEmailSender(
        IEmailService emailService,
        EmailServiceEmailSenderOptions options)
    {
        this.emailService = Check.NotNull(emailService, nameof(emailService));
        this.options = Check.NotNull(options, nameof(options));
    }

    public async Task SendAsync(
        string toAddress,
        string toName,
        int toReferralNumber,
        EmailBody body,
        params Application.EmailSender.EmailAttachment[] attachments)
    {
        var emailMessage = BuildEmailMessage(toAddress, toName, toReferralNumber, body, attachments);

        await emailService.SendAsync(emailMessage).ConfigureAwait(false);
    }

    private EmailMessage BuildEmailMessage(
        string toAddress,
        string toName,
        int toReferralNumber,
        EmailBody body,
        params Application.EmailSender.EmailAttachment[] attachments)
    {
        var emailServiceAttachments = attachments.Select(att =>
            new Common.Services.Email.Abstractions.EmailAttachment(att.Content, att.FileName)).ToArray();
        
        return new EmailMessage(
            fromAddress: options.FromEmail,
            toAddress: new EmailAddress(toAddress, toName),
            content: new StreamEmailContent(body.Content, body.IsHtml),
            subject: toReferralNumber + " - " + options.EmailSubject,
            attachments: emailServiceAttachments);
    }
}
