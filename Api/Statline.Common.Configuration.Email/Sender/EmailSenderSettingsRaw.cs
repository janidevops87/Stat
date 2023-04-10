using Statline.Common.Configuration.Email.Smtp;
using Statline.Extensions.Configuration.Reference;

namespace Statline.Common.Configuration.Email.Sender
{
    internal class EmailSenderSettingsRaw
    {
        public ConfigurationSectionReference<SmtpServerSettings> 
            SmtpServerSettingsReference { get; set; }
        public string FromEmail { get; set; }
        public string ToEmails { get; set; }
        public string EmailSubject { get; set; }
    }
}
