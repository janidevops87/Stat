using System.ComponentModel.DataAnnotations;

namespace Statline.IdentityServer.Features.IdentityAndAccess.Role.ViewModels
{
    public class NewRoleViewModel
    {
        [Required]
        [StringLength(256)]
        [Display(Name = "Name")]
        public string Name { get; set; }
    }
}
