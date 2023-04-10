using System.ComponentModel.DataAnnotations;

namespace Statline.IdentityServer.Features.IdentityAndAccess.User.ViewModels
{
    public class RoleViewModel : UserViewModel
    {
        [Display(Name = "Role Name")]
        [Required]
        [StringLength(256)]
        public string Name { get; set; }
    }
}