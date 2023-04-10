using System.ComponentModel.DataAnnotations;

namespace Statline.IdentityServer.Features.IdentityAndAccess.User.ViewModels
{
    public class NewUserViewModel
    {
        [Required]
        [StringLength(256)]
        [Display(Name = "User Name")]
        public string ClientId { get; set; }

        [Required]
        [StringLength(256)]
        [Display(Name = "Email")]
        public string Email { get; set; }

    }
}
