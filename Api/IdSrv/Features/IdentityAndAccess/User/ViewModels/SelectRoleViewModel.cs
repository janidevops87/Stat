using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace Statline.IdentityServer.Features.IdentityAndAccess.User.ViewModels
{
    public class SelectRoleViewModel : UserViewModel
    {
        [Display(Name = "Role Name")]
        [Required]
        public string SelectedRoleName { get; set; }

        public List<SelectListItem> AllRoles { get; } = new List<SelectListItem>();
    }
}
