using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace Emailer.MessageProcessor.Infrastructure.FallbackMessageSender
{
    public class FallbackMessageSenderDecoratorOptions
    {
        public string? EmailSubject { get; set; }

        [Required]
        [MinLength(1)]
        public ICollection<string> ToEmails { get; set; } = default!;
    }
}
