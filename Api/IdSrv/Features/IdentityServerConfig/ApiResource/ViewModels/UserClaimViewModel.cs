using System.ComponentModel.DataAnnotations;

namespace Statline.IdentityServer.Features.IdentityServerConfig.Api.ViewModels
{
    public class UserClaimViewModel : ApiResourceViewModel
    {
        [Display(Name = "Type")]
        [Required]
        [StringLength(200)]
        public string Type { get; set; }
    }
}
