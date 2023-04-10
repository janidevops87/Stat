using Statline.Common.Configuration.Email.Smtp;
using Statline.Common.Utilities;

namespace Statline.Common.Configuration.Email.Sender
{
    public class EmailSenderSettings
    {
        public SmtpServerSettings SmtpServerSettings { get; internal set; }
        public string FromEmail { get; internal set; }
        public string ToEmails { get; internal set; }
        public string EmailSubject { get; internal set; }

        public void Validate(string referencingPath)
        {
            Check.NotEmpty(referencingPath, nameof(referencingPath));
            Check.NotNull(SmtpServerSettings, referencingPath + "." + nameof(SmtpServerSettings));
            Check.NotEmpty(FromEmail, referencingPath + "." + nameof(FromEmail));
            Check.NotEmpty(ToEmails, referencingPath + "." + nameof(FromEmail));

            SmtpServerSettings.Validate(referencingPath + "." + nameof(SmtpServerSettings));
        }
    }
}
