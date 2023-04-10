using Microsoft.ApplicationInsights.Channel;
using Microsoft.ApplicationInsights.Extensibility;
using Microsoft.AspNetCore.Http;
using Statline.Common.Utilities;

namespace Statline.Common.Infrastructure.Azure.ApplicationIsights
{
    /// <summary>
    /// By default, Application Insights tracks just an anonymous user ID.
    /// This class includes "real" user name in the telemetry.
    /// </summary>
    public class UserNameTelemetryInitializer : ITelemetryInitializer
    {
        private IHttpContextAccessor httpContextAccessor;

        public UserNameTelemetryInitializer(IHttpContextAccessor httpContextAccessor)
        {
            Check.NotNull(httpContextAccessor, nameof(httpContextAccessor));
            this.httpContextAccessor = httpContextAccessor;
        }

        public void Initialize(ITelemetry telemetry)
        {
            var httpContext = httpContextAccessor.HttpContext;

            if (httpContext != null &&
                httpContext.User.Identity.IsAuthenticated &&
                httpContext.User.Identity.Name != null)
            {
                telemetry.Context.User.AuthenticatedUserId =
                    httpContext.User.Identity.Name;
            }
        }
    }
}
