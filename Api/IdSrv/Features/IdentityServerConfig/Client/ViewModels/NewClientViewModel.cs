using System.ComponentModel.DataAnnotations;

namespace Statline.IdentityServer.Features.IdentityServerConfig.Client.ViewModels
{
    public class NewClientViewModel
    {
        [Required]
        [StringLength(200)]
        [Display(Name = "Client Id")]
        public string ClientId { get; set; }

        [Required]
        [StringLength(200)]
        [Display(Name = "Client Name")]
        public string ClientName { get; set; }

        [Required]
        [Display(Name = "Tenant")]
        public EditTenantViewModel Tenant { get; }
            = new EditTenantViewModel();
    }
}
