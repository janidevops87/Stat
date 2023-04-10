using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using Statline.Registry.Web.UI.Framework.Routes;
using Statline.Configuration;
using Statline.StatTrac.Web.UI;
using System.Web.Routing;

namespace Statline.Registry.Web.UI
{
    public class Global : BaseApplication
    {

        protected override void RegisterRoutes(RouteCollection routes)
        {   /// RegisterRoutes inherits and overrides BaseApplication
            /// and gets/sets route information from the registry Enrollment form.
            /// The routesLocation is configurable in web.config.
            /// The 'en' (english) language is defined as a default route.
            string routesLocation;
            routesLocation = ApplicationSettings.GetSetting(SettingName.RoutesEnrollment);
            routes.Add("", new Route(
                routesLocation , new RouteValueDictionary { { "language", "en" } },
                new DynamicRouteHandler()));
        }

    }
}