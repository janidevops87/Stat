using System.ComponentModel.DataAnnotations;

namespace Statline.IdentityServer.Features.IdentityServerConfig.Client.ViewModels
{
    public class ClaimViewModel : ClientViewModel
    {
        [Display(Name = "Type")]
        [Required]
        [StringLength(250)]
        public string Type { get; set; }

        [Display(Name = "Value")]
        [Required]
        [StringLength(250)]
        public string Value { get; set; }
    }
}
