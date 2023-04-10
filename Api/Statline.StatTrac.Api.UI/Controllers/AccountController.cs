using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Http;
using IdentityModel.Client;
using System.Net.Http;
using Microsoft.AspNetCore.Authentication;
using Newtonsoft.Json.Linq;

namespace Statline.StatTrac.Api.UI.Controllers
{

    public class AccountController : Controller
    {
        public async Task Logout()
        {
            await HttpContext.SignOutAsync("Cookies");
            await HttpContext.SignOutAsync("oidc");
        }       
    }
}
