using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;

namespace Statline.IdentityServer.Helper
{
    // TODO: Consider using this library instead: https://github.com/NWebsec/NWebsec.
    public class SecurityHeadersAttribute : ActionFilterAttribute
    {
        public override void OnResultExecuting(ResultExecutingContext context)
        {
            var result = context.Result;
            if (result is ViewResult)
            {
                // https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Content-Type-Options
                if (!context.HttpContext.Response.Headers.ContainsKey("X-Content-Type-Options"))
                {
                    context.HttpContext.Response.Headers.Add("X-Content-Type-Options", "nosniff");
                }

                // https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Frame-Options
                if (!context.HttpContext.Response.Headers.ContainsKey("X-Frame-Options"))
                {
                    context.HttpContext.Response.Headers.Add("X-Frame-Options", "SAMEORIGIN");
                }

                // https://stackoverflow.com/questions/30280370/how-does-content-security-policy-work
                // https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy
                // https://developers.google.com/web/fundamentals/security/csp/
                // https://content-security-policy.com/
                var csp = "default-src 'self'; object-src 'none'; frame-ancestors 'none'; sandbox allow-forms allow-same-origin allow-scripts; base-uri 'self';";

                // Configure allowed sources for CDN(s), space separated.
                string cdnList = "https://ajax.aspnetcdn.com/";

                // 'unsafe-inline' for script-src is needed 
                // for asp-fallback-* tag helper family, 
                // which is implemented as inline script.
                // 'unsafe-inline' for style-src is needed 
                // for asp-validation-summary, which uses inline style.
                // The issue which tracks these problems: https://github.com/aspnet/Mvc/issues/4300.
                // TODO: Remove these 'unsafe-inline's once the issue is fixed.
                csp += $"script-src 'self' 'unsafe-inline' {cdnList};";
                csp += $"style-src 'self' 'unsafe-inline' {cdnList};";
                csp += $"font-src 'self'  {cdnList};";

                // also consider adding upgrade-insecure-requests once you have HTTPS in place for production
                // csp += "upgrade-insecure-requests;";
                // also an example if you need client images to be displayed from twitter
                // csp += "img-src 'self' https://pbs.twimg.com;";

                // once for standards compliant browsers
                if (!context.HttpContext.Response.Headers.ContainsKey("Content-Security-Policy"))
                {
                    context.HttpContext.Response.Headers.Add("Content-Security-Policy", csp);
                }
                // and once again for IE
                if (!context.HttpContext.Response.Headers.ContainsKey("X-Content-Security-Policy"))
                {
                    context.HttpContext.Response.Headers.Add("X-Content-Security-Policy", csp);
                }

                // https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Referrer-Policy
                var referrer_policy = "no-referrer";
                if (!context.HttpContext.Response.Headers.ContainsKey("Referrer-Policy"))
                {
                    context.HttpContext.Response.Headers.Add("Referrer-Policy", referrer_policy);
                }
            }
        }
    }
}
