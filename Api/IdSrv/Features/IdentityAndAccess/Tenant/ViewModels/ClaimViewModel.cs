using System.ComponentModel.DataAnnotations;

namespace Statline.IdentityServer.Features.IdentityAndAccess.Tenant.ViewModels
{
    public class ClaimViewModel : TenantViewModel
    {
        [Display(Name = "Type")]
        [Required]
        [StringLength(250)] // Currently unlimited in the DB.
        public string Type { get; set; }

        [Display(Name = "Value")]
        [Required]
        [StringLength(250)] // Currently unlimited in the DB.
        public string Value { get; set; }
    }
}