using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Razor.TagHelpers;
using Statline.IdentityServer.TagHelpers.Extensions;
using System.ComponentModel;
using System.Threading.Tasks;

namespace Statline.IdentityServer.TagHelpers
{
    [HtmlTargetElement("input")]
    [HtmlTargetElement("button")]
    [HtmlTargetElement("optgroup")]
    [HtmlTargetElement("select")]
    [HtmlTargetElement("textarea")]
    [EditorBrowsable(EditorBrowsableState.Never)]
    public class FormInputTagHelper : AuthorizationTagHelper
    {
        public FormInputTagHelper(IAuthorizationService authorizationService)
            : base(authorizationService)
        {
        }

        public override async Task ProcessAsync(TagHelperContext context, TagHelperOutput output)
        {
            /// The policies are placed to the context by the <see cref="FormTagHelper"/>.
            var authorizePolicies = ViewContextData.GetAuthorizePolicies();

            // TODO: I'm not happy with calling this asynchronous method for 
            // every form input tag, since each input of the same form will 
            // have same set of policies and same authorization result. It
            // would be much better to make this check once - in the form tag helper,
            // and then just pass the result in the context.
            // However, to be called before child tags, this code would have to
            // be placed in Init method, and this one has only synchronous version,
            // making this approach impossible. I filed an issue for that:
            // https://github.com/aspnet/Razor/issues/2057.
            //
            if (!await AuthorizationPoliciesSatisfiedAsync(authorizePolicies))
            {
                output.Attributes.Add("disabled", null);
            }
        }
    }
}
