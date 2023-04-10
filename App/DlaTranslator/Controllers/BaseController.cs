using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web.Mvc;
using System.Web.Security;
using Newtonsoft.Json;
using Registry.Common.DTO;
using Registry.Web.UI.DAL;
using Statline.Stattrac.Framework;

namespace Registry.Web.UI.Controllers
{
    public class BaseController : Controller
    {
        protected readonly IApiDataProvider ApiDataProvider;
        private IList<RegistryOwner> _clients;

        protected IList<RegistryOwner> Clients
        {
            get
            {
                _clients = HttpContext.Application["Clients"] as IList<RegistryOwner>;

                if (_clients == null)
                {
                    _clients = Task.Run(() => ApiDataProvider.GetRegistryOwners()).Result;
                    HttpContext.Application["Clients"] = _clients;
                }

                return _clients;
            }
        }

        protected RegistryOwner CurrentClient
        {
            get
            {
                if (CurrentUser != null && Clients != null)
                    return Clients.FirstOrDefault(x => x.RegistryOwnerId == CurrentUser.RegistryOwnerId);

                return null;
            }
        }

        protected bool CaptchaOn(string client)
        {
            return CurrentUser == null &&
                   (Clients.FirstOrDefault(x => x.RegistryOwnerRouteName.Equals(client))?.CaptchaOn ?? true);
        }

        private UserAuthenticationTicket _currentUser;

        public UserAuthenticationTicket CurrentUser
        {
            get
            {
                if (!HttpContext.User.Identity.IsAuthenticated)
                    return null;

                if (_currentUser == null)
                {
                    var cookie = HttpContext.Request.Cookies["user"];
                    var ticket = FormsAuthentication.Decrypt(cookie.Value);
                    _currentUser = JsonConvert.DeserializeObject<UserAuthenticationTicket>(ticket.UserData);
                }

                return _currentUser;
            }
        }

        protected BaseController(IApiDataProvider provider)
        {
            ApiDataProvider = provider;
        }

        protected override void OnException(ExceptionContext filterContext)
        {
            BaseLogger.LogFormUnhandledException(filterContext.Exception);
            base.OnException(filterContext);
        }
    }
}