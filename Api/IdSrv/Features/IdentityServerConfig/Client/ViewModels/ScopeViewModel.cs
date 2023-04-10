using System.ComponentModel.DataAnnotations;

namespace Statline.IdentityServer.Features.IdentityServerConfig.Client.ViewModels
{
    public class ScopeViewModel : ClientViewModel
    {
        [Required]
        [StringLength(200)]
        [Display(Name = "Scope")]
        public string Value { get; set; }
    }
}
