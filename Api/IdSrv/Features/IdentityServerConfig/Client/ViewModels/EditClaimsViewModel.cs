using System.ComponentModel.DataAnnotations;

namespace Statline.IdentityServer.Features.IdentityServerConfig.Client.ViewModels
{
    public class EditClaimsViewModel : ClientViewModel
    {
        [Display(Name = "Claims")]
        public ClaimViewModel[] Claims { get; set; }
    }
}
