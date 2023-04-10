using System.ComponentModel.DataAnnotations;

namespace Statline.IdentityServer.Features.IdentityServerConfig.Client.ViewModels
{
    public class EditRedirectUrisViewModel : ClientViewModel
    {
        [Display(Name = "Redirect Uris")]
        public RedirectUriViewModel[] RedirectUris { get; set; }
    }
}