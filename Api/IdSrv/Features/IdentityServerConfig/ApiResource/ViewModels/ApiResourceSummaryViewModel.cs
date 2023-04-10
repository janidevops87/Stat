using System.ComponentModel.DataAnnotations;

namespace Statline.IdentityServer.Features.IdentityServerConfig.Api.ViewModels
{
    public class ApiResourceSummaryViewModel
    {
        [Display(Name = "Id")]
        public int Id { get; set; }

        [Display(Name = "Name")]
        public string Name { get; set; }

        [Display(Name = "Display Name")]
        public string DisplayName { get; set; }
    }
}
