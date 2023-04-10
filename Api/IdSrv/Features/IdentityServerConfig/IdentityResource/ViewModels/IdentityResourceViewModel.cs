using System.ComponentModel.DataAnnotations;

namespace Statline.IdentityServer.Features.IdentityServerConfig.Identity.ViewModels
{
    public class IdentityResourceViewModel
    {
        // These properties are intended to be logically read-only.
        [Display(Name = "Id")]
        public int IdentityResourceId { get; set; }

        [Display(Name = "Name")]
        public string IdentityResourceName { get; set; }
    }
}
