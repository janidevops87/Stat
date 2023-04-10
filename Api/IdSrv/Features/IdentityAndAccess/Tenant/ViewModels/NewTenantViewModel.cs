using System.ComponentModel.DataAnnotations;

namespace Statline.IdentityServer.Features.IdentityAndAccess.Tenant.ViewModels
{
    public class NewTenantViewModel
    {
        [Required]
        [StringLength(256)]
        [Display(Name = "Organization Name")]
        public string OrganizationName { get; set; }
    }
}
