#nullable enable

using System.ComponentModel.DataAnnotations;

namespace Statline.StatTrac.StatFax.Infrastructure.EmailSender.EmailService;

public class EmailServiceEmailSenderOptions
{
    [Required]
    public string FromEmail { get; set; } = default!;
    public string? EmailSubject { get; set; }
}
