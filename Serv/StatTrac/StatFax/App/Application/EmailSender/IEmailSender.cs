using System.Threading.Tasks;

namespace Statline.StatTrac.StatFax.Application.EmailSender
{
    public interface IEmailSender
    {
        Task SendAsync(
            string toAddress, 
            string toName, 
            int toReferralNumber,
            EmailBody body, 
            params EmailAttachment[] attachments);
    }
}