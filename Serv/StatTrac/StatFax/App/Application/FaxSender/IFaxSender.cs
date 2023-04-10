using System.Threading.Tasks;

namespace Statline.StatTrac.StatFax.Application.FaxSender
{
    public interface IFaxSender
    {
        Task<string> SendAsync(string toName, string toNumber, FaxBody body);
    }
}