using System.Threading.Tasks;

namespace Statline.StatTrac.Api.Infrastructure.Http
{
    public interface IAuthenticationProvider
    {
        Task<AuthenticationResult> AuthenticateAsync();
    }
}
