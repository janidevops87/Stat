using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace Statline.IdentityServer.Features.IdentityAndAccess.User.ViewModels
{
    public class EditPropertiesViewModel : UserViewModel
    {
        [Required]
        [StringLength(256)]
        [Display(Name = "User Name")]
        public string EditableUserName { get; set; }

        [Required]
        [EmailAddress]
        [Display(Name = "Email")]
        [StringLength(256)]
        public string Email { get; set; }
    }
}