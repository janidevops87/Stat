using Statline.IdentityServer.Features.IdentityAndAccess.Tenant.ViewModels;
using System.ComponentModel.DataAnnotations;

namespace Statline.IdentityServer.Features.IdentityAndAccess.Tenant.ViewModels
{
    public class EditClaimsViewModel : TenantViewModel
    {
        [Display(Name = "Claims")]
        public ClaimViewModel[] Claims { get; set; }
    }
}