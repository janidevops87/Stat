using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Razor.TagHelpers;
using System.Threading.Tasks;

namespace Statline.IdentityServer.TagHelpers
{
    public class AuthorizeTagHelper : AuthorizationTagHelper
    {
        /// <summary>
        /// The list of UI viewing authorization policies.
        /// </summary>
        public string ViewPolicies { get; set; }

        public AuthorizeTagHelper(IAuthorizationService authorizationService)
            : base(authorizationService)
        {
        }

        public override async Task ProcessAsync(TagHelperContext context, TagHelperOutput output)
        {
            // Always strip the outer tag name as we never want <authorize> to render.
            output.TagName = null;

            if (!await AuthorizationPoliciesSatisfiedAsync(ViewPolicies))
            {
                HideContent(output);
            }
        }

        private void HideContent(TagHelperOutput output) => output.SuppressOutput();
    }
}
