using System.ComponentModel.DataAnnotations;

namespace Statline.IdentityServer.Features.IdentityServerConfig.Api.ViewModels
{
    public class EditScopesViewModel : ApiResourceViewModel
    {
        [Display(Name = "Scopes")]
        public ScopeViewModel[] Scopes { get; set; }
    }
}