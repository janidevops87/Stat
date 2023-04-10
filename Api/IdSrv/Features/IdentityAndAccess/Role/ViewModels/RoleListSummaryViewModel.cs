using System.ComponentModel.DataAnnotations;

namespace Statline.IdentityServer.Features.IdentityAndAccess.Role.ViewModels
{
    public class RoleListSummaryViewModel
    {
        [Display(Name = "Id")]
        public string Id { get; set; }

        [Display(Name = "Name")]
        public string Name { get; set; }
    }
}