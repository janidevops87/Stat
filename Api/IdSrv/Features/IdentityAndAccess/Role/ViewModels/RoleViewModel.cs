using System.ComponentModel.DataAnnotations;

namespace Statline.IdentityServer.Features.IdentityAndAccess.Role.ViewModels
{
    public class RoleViewModel
    {
        // This property is intended to be logically read-only.
        [Display(Name = "Name")]
        public string Name { get; set; }

        [Display(Name = "Id")]
        public string Id { get; set; }
    }
}
