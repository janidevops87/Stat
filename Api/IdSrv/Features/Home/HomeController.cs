using System.Diagnostics;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Statline.IdentityServer.Common.Security;
using Statline.IdentityServer.Features.Home.ViewModels;

namespace Statline.IdentityServer.Features.Home
{
    public class HomeController : Controller
    {
        public IActionResult Index()
        {
            return RedirectToAction(nameof(UserInfo));
        }

        public async Task<IActionResult> UserInfo()
        {
            var authProps =
                (await HttpContext.AuthenticateAsync(User.Identity.AuthenticationType)).Properties;


            var vm = new UserInfoViewModel
            {
                Claims = User.Claims,
                StatlineClaims = User.GetStatlineClaims(),
                Name = User.Identity.Name,
                TenantId = User.GetTenantId(),
                Id = User.GetUserId(),
                Email = User.GetEmail(),
                FirstName = User.GetGivenName(),
                LastName = User.GetFamilyName(),
                Roles = User.GetRoles(),
                CookieProperties = authProps.Items
            };

            return View(vm);
        }

        [AllowAnonymous]
        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
