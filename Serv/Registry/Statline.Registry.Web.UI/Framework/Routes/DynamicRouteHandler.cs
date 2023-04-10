using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Web.Routing;
using System.Web.Compilation;

namespace Statline.Registry.Web.UI.Framework.Routes
{
    public class DynamicRouteHandler : IRouteHandler

    {
        #region IRouteHandler Members

        public IHttpHandler GetHttpHandler(RequestContext requestContext)
        {
            /// Get route request information and set HttpContext current item property

            string languageCode = string.Empty;
            string mobile = "m";
            string requestedRoutePath = "~/Register/Dynamic/Enrollment.aspx";

            HttpContext.Current.Items["Owner"] = requestContext.RouteData.Values["Owner"];
            HttpContext.Current.Items["language"] = requestContext.RouteData.Values["language"];

            languageCode = HttpContext.Current.Items["language"].ToString();

            if (languageCode.Length > 0)
            {
                // Check to see if this is a mobile route.
                // If it is, re-define the route path to mobile page.
                if (languageCode.Substring(0, 1) == mobile)
                {
                    requestedRoutePath = "~/Register/Dynamic/EnrollmentMobile.aspx";
                }
            }

            // Re-direct to requested route path
            return BuildManager.CreateInstanceFromVirtualPath(requestedRoutePath.ToString(), typeof(Page)) as Page; 

        }

        #endregion
    }
}
