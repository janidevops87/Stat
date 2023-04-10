using System.ComponentModel.DataAnnotations;

namespace Statline.IdentityServer.Features.IdentityServerConfig.Api.ViewModels
{
    public class EditUserClaimsViewModel : ApiResourceViewModel
    {
        [Display(Name = "User Claims")]
        public UserClaimViewModel[] UserClaims { get; set; }
    }
}
