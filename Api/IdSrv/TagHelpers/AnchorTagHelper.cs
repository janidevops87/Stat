using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Razor.TagHelpers;
using Statline.IdentityServer.TagHelpers.Extensions;
using System.Text.Encodings.Web;
using System.Threading.Tasks;

namespace Statline.IdentityServer.TagHelpers
{
    [HtmlTargetElement("a", Attributes = AuthorizeAttributeName)]
    public class AnchorTagHelper : AuthorizationTagHelper
    {
        private const string AuthorizeAttributeName = "asp-authorize";

        private readonly HtmlEncoder htmlEncoder;

        /// <summary>
        /// The list of authorization policies.
        /// </summary>
        [HtmlAttributeName(AuthorizeAttributeName)]
        public string Authorize { get; set; }

        public AnchorTagHelper(
            IAuthorizationService authorizationService,
            HtmlEncoder htmlEncoder)
            : base(authorizationService)
        {
            this.htmlEncoder = htmlEncoder;
        }

        public override async Task ProcessAsync(TagHelperContext context, TagHelperOutput output)
        {
            if(!await AuthorizationPoliciesSatisfiedAsync(Authorize))
            {
                MakeDisabled(output);
            }
        }

        private void MakeDisabled(TagHelperOutput output)
        {
            // Assume the class is defined (e.g. Bootstrap).
            output.AddClass("disabled", htmlEncoder);

            // To avoid navigating to the link by tab and pressing Enter.
            output.Attributes.RemoveAll("href");
        }
    }
}
