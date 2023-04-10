using System.Threading.Tasks;

namespace Statline.StatTrac.Api.DemoClient.Http
{
    public interface IAuthenticationProvider
    {
        Task<AuthenticationResult> AuthenticateAsync();
    }
}
