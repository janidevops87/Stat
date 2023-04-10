using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Razor.TagHelpers;
using Statline.IdentityServer.TagHelpers.Extensions;

namespace Statline.IdentityServer.TagHelpers
{
    [HtmlTargetElement("form", Attributes = AuthorizeAttributeName)]
    public class FormTagHelper : AuthorizationTagHelper
    {
        private const string AuthorizeAttributeName = "asp-authorize";
        
        /// <summary>
        /// The list of authorization policies.
        /// </summary>
        [HtmlAttributeName(AuthorizeAttributeName)]
        public string Authorize { get; set; }

        
        public FormTagHelper(IAuthorizationService authorizationService)
            :base(authorizationService)
        {
        }

        public override void Init(TagHelperContext context)
        {
            /// Store the policies to the context for child <see cref="FormInputTagHelper"/>'s.
            ViewContextData.AddAuthorizePolicies(ParseAuthorizationPolicies(Authorize));
        }
    }
}
