using System.ComponentModel.DataAnnotations;

namespace Statline.IdentityServer.Features.IdentityServerConfig.Client.ViewModels
{
    public class EditScopesViewModel : ClientViewModel
    {
        [Display(Name = "Scopes")]
        public ScopeViewModel[] AllowedScopes { get; set; }
    }
}