using Microsoft.Extensions.Options;
using System.Net.Mail;
using System.Threading.Tasks;

namespace Stattrac.Reporting
{
    public class EmailService : IEmailService
    {
        private Settings _setting;

        public EmailService(IOptions<Settings> setting)
        {
            _setting = setting.Value;
        }

        public async Task SendEmailAsync(string to, string subject, string body)
        {
            var client = new SmtpClient(_setting.Email.Host);
            client.Port = _setting.Email.Port;
            client.EnableSsl = false;

            var mailMessage = new MailMessage(_setting.Email.UserName, to, subject, body);
            mailMessage.IsBodyHtml = true;

            await client.SendMailAsync(mailMessage);
        }
    }
}