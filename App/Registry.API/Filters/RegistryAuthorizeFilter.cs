using System;
using System.Net;
using System.Net.Http;
using System.Security.Principal;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.Http;

namespace Registry.API.Filters
{
    public class RegistryAuthorizeFilter : AuthorizeAttribute
    {   
        public override void OnAuthorization(System.Web.Http.Controllers.HttpActionContext actionContext)
        {
            if (actionContext.Request.Headers.Authorization == null)
            {
                var result = new HttpResponseMessage { StatusCode = HttpStatusCode.Unauthorized };
                result.Headers.Add("WWW-Authenticate", "Basic");
                actionContext.Response = result;
            }
            else
            {
                string authToken = actionContext.Request.Headers.Authorization.Parameter;
                string decodedToken = Encoding.UTF8.GetString(Convert.FromBase64String(authToken));
                string user = decodedToken.Substring(0, decodedToken.IndexOf(":", StringComparison.Ordinal));
                string password = decodedToken.Substring(decodedToken.IndexOf(":", StringComparison.Ordinal) + 1);
                
                if (!(WebConfigurationManager.AppSettings["ApiUser"]==user && WebConfigurationManager.AppSettings["ApiPassword"]== password))
                {
                    var result = new HttpResponseMessage { StatusCode = HttpStatusCode.Unauthorized };
                    actionContext.Response = result;
                }
                else
                {
                    GenericIdentity identity = new GenericIdentity(user);
                    GenericPrincipal principal =new GenericPrincipal(identity,null);
                    HttpContext.Current.User = principal;
                    base.OnAuthorization(actionContext);
                }
            }
        }
    }
}