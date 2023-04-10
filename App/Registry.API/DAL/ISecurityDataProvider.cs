using System.Collections.Generic;
using System.Threading.Tasks;
using Registry.Common.DTO;

namespace Registry.API.DAL
{
    public interface ISecurityDataProvider
    {
        ////Task<bool> Login(string userName, string password);
        Task<UserAuthenticationTicket> Login(string userName, string password);
        Task<IList<RegistryOwner>> GetClients();
    }
}
