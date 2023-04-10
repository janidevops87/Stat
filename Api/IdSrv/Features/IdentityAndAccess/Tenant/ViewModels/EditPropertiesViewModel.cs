using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace Statline.IdentityServer.Features.IdentityAndAccess.Tenant.ViewModels
{
    public class EditPropertiesViewModel : TenantViewModel
    {
        [Required]
        [StringLength(256)]
        [Display(Name = "Organization Name")]
        public string EditableOrganizationName { get; set; }
    }
}