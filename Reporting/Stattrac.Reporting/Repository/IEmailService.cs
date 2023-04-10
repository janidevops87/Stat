using System.Threading.Tasks;

namespace Stattrac.Reporting
{
    public interface IEmailService
    {
        Task SendEmailAsync(string to, string subject, string body);
    }
}