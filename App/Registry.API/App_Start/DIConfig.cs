using System.Web.Http;
using Autofac;
using Autofac.Integration.WebApi;
using Registry.API.DAL;

namespace Registry.API
{
    public static class DIConfig
    {
        public static void RegisterDependencies(HttpConfiguration config)
        {
            var builder = new ContainerBuilder();
            builder.RegisterTypes(
                typeof(EFRefDataProvider)
                , typeof(EFSecurityDataProvider)
                , typeof(EFCategoryDataProvider)
                , typeof(EFEnrollmentDataProvider)
                , typeof(EFSearchDataProvider)
                , typeof(ReportDataProvider)
            ).AsImplementedInterfaces().InstancePerRequest();
            builder.RegisterApiControllers(typeof(WebApiApplication).Assembly);
            var container = builder.Build();
            config.DependencyResolver = new AutofacWebApiDependencyResolver(container);
        }
    }
}
