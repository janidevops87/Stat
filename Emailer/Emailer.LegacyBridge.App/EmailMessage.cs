using Statline.Common.Utilities;

namespace Emailer.LegacyBridge.App
{
    public class EmailMessage
    {
        public EmailMessage(
            int id,
            string from,
            string to,
            string? cc,
            string? bcc,
            string? subject, 
            string? body)
        {
            Id = id;
            From = Check.NotEmpty(from, nameof(from));
            To = Check.NotEmpty(to, nameof(to));
            CC = cc;
            Bcc = bcc;
            Subject = subject;
            Body = body;
        }

        public int Id { get; }

        public string To { get; }
        public string? CC { get; }
        public string? Bcc { get; }

        public string From { get; }
        public string? Subject { get; }
        public string? Body { get; }
    }
}
