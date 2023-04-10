using System.ComponentModel.DataAnnotations;

namespace Statline.IdentityServer.Features.IdentityServerConfig.Identity.ViewModels
{
    public class EditPropertiesViewModel : IdentityResourceViewModel
    {
        [Required]
        [StringLength(200)]
        [Display(Name = "Name")]
        public string Name { get; set; }

        [Required]
        [StringLength(200)]
        [Display(Name = "Display Name")]
        public string DisplayName { get; set; }

        [StringLength(1000)]
        [Display(Name = "Description")]
        public string Description { get; set; }

        [Required]
        [Display(Name = "Required")]
        public bool Required { get; set; }

        [Required]
        [Display(Name = "Emphasize on the consent screen")]
        public bool Emphasize { get; set; }

    }
}
