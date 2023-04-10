using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace Statline.IdentityServer.Features.IdentityServerConfig.Client.ViewModels
{
    public class EditTenantViewModel
    {
        [Display(Name = "Tenant")]
        [Required]
        [Range(0, int.MaxValue)]
        public int SelectedTenantId { get; set; }

        public List<SelectListItem> AllTenants { get; } = new List<SelectListItem>();

    }
}
