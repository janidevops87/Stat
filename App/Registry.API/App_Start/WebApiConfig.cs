using System.Web.Http;
using Registry.API.Filters;

namespace Registry.API
{
    public static class WebApiConfig
    {
        public static void Register(HttpConfiguration config)
        {
            // Web API configuration and services

            // Web API routes
            config.MapHttpAttributeRoutes();

            config.Routes.MapHttpRoute(
                name: "DefaultApi",
                routeTemplate: "api/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );

            // Dependencies
            DIConfig.RegisterDependencies(config);

            config.Filters.Add(new RegistryAuthorizeFilter());
            config.Filters.Add(new ExceptionLogFilter());
        }
    }
}
