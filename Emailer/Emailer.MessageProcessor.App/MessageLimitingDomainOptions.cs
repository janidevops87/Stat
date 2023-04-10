using System.ComponentModel.DataAnnotations;

namespace Emailer.MessageProcessor.App
{
    public class MessageLimitingDomainOptions
    {
        [Required]
        public string Domain { get; set; } = default!;
        public int SizeLimit { get; set; }
    }
}
