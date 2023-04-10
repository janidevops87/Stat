using System.ComponentModel.DataAnnotations;

namespace Statline.IdentityServer.Features.IdentityServerConfig.Identity.ViewModels
{
    public class UserClaimViewModel : IdentityResourceViewModel
    {
        [Display(Name = "Type")]
        [Required]
        [StringLength(200)]
        public string Type { get; set; }
    }
}
