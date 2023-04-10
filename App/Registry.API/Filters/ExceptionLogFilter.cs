using System.Web.Http.Filters;
using Registry.Common.Util;

namespace Registry.API.Filters
{
    public class ExceptionLogFilter : ExceptionFilterAttribute
    {
        public override void OnException(HttpActionExecutedContext context)
        {
            var logger = RegistryLogger.CreateInstance("Registry.API");
            logger.Write(context.Exception);

            base.OnException(context);
        }
    }
}