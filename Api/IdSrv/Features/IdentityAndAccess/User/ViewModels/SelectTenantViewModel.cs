using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace Statline.IdentityServer.Features.IdentityAndAccess.User.ViewModels
{
    public class SelectTenantViewModel
    {
        [Display(Name = "Target tenant")]
        [Required]
        [Range(0, int.MaxValue)]
        public int? SelectedTenantId { get; set; }

        public List<SelectListItem> AllTenants { get; } = new List<SelectListItem>();
    }
}
