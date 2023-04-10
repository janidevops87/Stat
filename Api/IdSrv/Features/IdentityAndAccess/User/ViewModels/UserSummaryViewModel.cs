using System.ComponentModel.DataAnnotations;

namespace Statline.IdentityServer.Features.IdentityAndAccess.User.ViewModels
{
    public class UserSummaryViewModel
    {
        [Display(Name = "Id")]
        public string Id { get; set; }

        [Display(Name = "Tenant id")]
        public int? TenantId { get; set; }

        [Display(Name = "Tenant organization name")]
        public string TenantOrganizationName { get; set; }

        [Display(Name = "User name")]
        public string UserName { get; set; }

        [Display(Name = "Is active")]
        public bool IsActive { get; set; }

        [Display(Name = "Is confirmed")]
        public bool IsConfirmed { get; set; }
    }
}
