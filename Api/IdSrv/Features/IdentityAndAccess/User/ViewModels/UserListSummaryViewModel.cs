using System.ComponentModel.DataAnnotations;

namespace Statline.IdentityServer.Features.IdentityAndAccess.User.ViewModels
{
    public class UserListSummaryViewModel
    {
        [Display(Name ="Id")]
        public string Id { get; set; }

        [Display(Name = "Tenant Id")]
        public int? TenantId { get; set; }

        [Display(Name = "Tenant organization name")]
        public string TenantOrganizationName { get; set; }

        [Display(Name = "Email")]
        public string Email { get; set; }

        [Display(Name = "User Name")]
        public string UserName { get; set; }

        [Display(Name = "Is Active")]
        public bool  IsActive { get; set; }

        [Display(Name = "Is Confirmed")]
        public bool IsConfirmed { get; set; }
        // We have this property to not put business 
        // logic into a view, the decision is made in the code. 
        public bool CanActivate { get; set; }
    }
}
