using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.AspNetCore.Mvc.ViewFeatures;
using Microsoft.AspNetCore.Razor.TagHelpers;
using Microsoft.Extensions.Primitives;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Statline.IdentityServer.TagHelpers
{
    public abstract class AuthorizationTagHelper : TagHelper
    {
        private static readonly char[] PolicySeparators = { ' ' };

        private readonly IAuthorizationService authorizationService;

        [ViewContext]
        [HtmlAttributeNotBound]
        public ViewContext ViewContextData { get; set; }

        protected AuthorizationTagHelper(IAuthorizationService authorizationService)
        {
            this.authorizationService = authorizationService;
        }

        protected IEnumerable<string> ParseAuthorizationPolicies(string formattedPolicies)
             => new StringTokenizer(formattedPolicies, PolicySeparators).Select(s => s.Value);

        
        protected async Task<bool> AuthorizationPoliciesSatisfiedAsync(IEnumerable<string> policies)
        {
            foreach (var policyName in policies)
            {
                if (!await AuthorizeUserAsync(policyName))
                {
                    return false;
                }
            }

            return true;
        }

        protected async Task<bool> AuthorizationPoliciesSatisfiedAsync(string formattedPolicies)
        {
            var policies = ParseAuthorizationPolicies(formattedPolicies);
            return await AuthorizationPoliciesSatisfiedAsync(policies);
        }

        private async Task<bool> AuthorizeUserAsync(string policyName)
        {
            return (await authorizationService.AuthorizeAsync(
                                ViewContextData.HttpContext.User,
                                policyName)).Succeeded;
        }
    }
}
