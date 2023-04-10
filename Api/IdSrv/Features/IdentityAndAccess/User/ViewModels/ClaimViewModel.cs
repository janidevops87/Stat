using System.ComponentModel.DataAnnotations;

namespace Statline.IdentityServer.Features.IdentityAndAccess.User.ViewModels
{
    public class ClaimViewModel : UserViewModel
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