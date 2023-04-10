using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace Statline.IdentityServer.Features.IdentityAndAccess.Tenant.ViewModels
{
    public class TenantViewModel
    {
        // This property is intended to be logically read-only.
        [Display(Name = "Organization Name")]
        public string OrganizationName { get; set; }

        [Display(Name = "Id")]
        public int Id { get; set; }
    }
}
