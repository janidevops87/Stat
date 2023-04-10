using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Statline.Common.Services.Email.Abstractions;
using Statline.Common.Utilities;

namespace Emailer.MessageProcessor.Infrastructure.MessageSender.EmailService;

/// <summary>
/// This implementation of <see cref="Domain.IEmailMessageSenderService"/> works like an adapter
/// for <see cref="IEmailService"/>.
/// </summary>
public class EmailServiceMessageSenderService :
    Domain.IEmailMessageSenderService
{
    private readonly IEmailService emailService;
    private readonly ILogger logger;
    private readonly IOptionsMonitor<EmailServiceMessageSenderServiceOptions> options;

    public EmailServiceMessageSenderService(
        IOptionsMonitor<EmailServiceMessageSenderServiceOptions> options,
        IEmailService emailService,
        ILogger<EmailServiceMessageSenderService> logger)
    {
        this.emailService = Check.NotNull(emailService);
        this.logger = Check.NotNull(logger);
        this.options = Check.NotNull(options);
    }

    public async Task SendMessageAsync(
        Domain.EmailMessage message,
        CancellationToken cancellationToken)
    {
        Check.NotNull(message);

        var options = this.options.CurrentValue;

        var emailServiceMessage = message.ToEmailServiceMessage(fromEmailOverride: options.FromEmail);

        logger.LogInformation("Sending email message with id = '{Id}' to '{ToAddresses}'",
            message.Id,
            message.To);

        try
        {
            await emailService.SendAsync(emailServiceMessage).ConfigureAwait(false);
        }
        catch (Exception ex)
        {
            // It might seem redundant to log here in addition to global unhandled exception logging.
            // However, this can be useful with retry decorator, when exceptions can be swallowed after retries.
            // TODO: Consider moving this logging to retry decorator.
            logger.LogError(
                exception: ex,
                message: "Error sending email message with id = '{Id}' to '{ToAddresses}'",
                message.Id, message.To);
            throw;
        }

        logger.LogInformation("Email message with id = '{Id}' sent.", message.Id);
    }
}
