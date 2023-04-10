using System.ComponentModel.DataAnnotations;

namespace Statline.IdentityServer.Features.IdentityServerConfig.Api.ViewModels
{
    public class ScopeViewModel : ApiResourceViewModel
    {
        [Required]
        [StringLength(200)]
        [Display(Name = "Name")]
        public string Name { get; set; }

        [Required]
        [StringLength(200)]
        [Display(Name = "Display Name")]
        public string DisplayName { get; set; }
    }
}
