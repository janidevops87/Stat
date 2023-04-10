using Statline.IdentityServer.Features.IdentityAndAccess.User.ViewModels;
using System.ComponentModel.DataAnnotations;

namespace Statline.IdentityServer.Features.IdentityAndAccess.User.ViewModels
{
    public class EditRolesViewModel : UserViewModel
    {
        [Display(Name = "Roles")]
        public RoleViewModel[] Roles { get; set; }
    }
}