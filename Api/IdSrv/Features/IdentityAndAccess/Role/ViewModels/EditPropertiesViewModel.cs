using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace Statline.IdentityServer.Features.IdentityAndAccess.Role.ViewModels
{
    public class EditPropertiesViewModel : RoleViewModel
    {
        [Required]
        [StringLength(256)]
        [Display(Name = "Name")]
        public string EditableName { get; set; }
    }
}