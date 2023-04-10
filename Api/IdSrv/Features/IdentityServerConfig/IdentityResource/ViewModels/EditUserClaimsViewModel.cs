using System.ComponentModel.DataAnnotations;

namespace Statline.IdentityServer.Features.IdentityServerConfig.Identity.ViewModels
{
    public class EditUserClaimsViewModel : IdentityResourceViewModel
    {
        [Display(Name = "User Claims")]
        public UserClaimViewModel[] UserClaims { get; set; }
    }
}
