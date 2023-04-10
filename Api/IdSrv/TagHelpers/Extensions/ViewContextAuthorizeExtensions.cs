using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.AspNetCore.Razor.TagHelpers; // Needed for xml docs.
using System.Collections.Generic;
using System.Linq;

namespace Statline.IdentityServer.TagHelpers.Extensions
{
    /// <dev>
    /// We have to use <see cref="ViewContext.ViewData"/> 
    /// instead of <see cref="TagHelperContext.Items"/> 
    /// because the latter doesn't support
    /// passing data across partial view and editor template boundary 
    /// as discussed here https://github.com/aspnet/Mvc/issues/3233.
    /// </dev>
    internal static class ViewContextAuthorizeExtensions
    {
        private static readonly string AuthorizePoliciesContextKey = "IdSrv.AuthorizePolicies";

        public static void AddAuthorizePolicies(
            this ViewContext viewContext,
            IEnumerable<string> policies)
        {
            viewContext.ViewData[AuthorizePoliciesContextKey] = policies;
        }

        public static IEnumerable<string> GetAuthorizePolicies(
           this ViewContext viewContext)
        {
            if (!viewContext.ViewData.TryGetValue(
                   AuthorizePoliciesContextKey,
                   out object authorizePolicies))
            {
                return Enumerable.Empty<string>();
            }

            var authorizePoliciesList = (IEnumerable<string>)authorizePolicies;

            return authorizePoliciesList;
        }
    }
}
