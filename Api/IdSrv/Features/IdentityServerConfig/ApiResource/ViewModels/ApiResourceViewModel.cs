using System.ComponentModel.DataAnnotations;

namespace Statline.IdentityServer.Features.IdentityServerConfig.Api.ViewModels
{
    public class ApiResourceViewModel
    {
        // These properties are intended to be logically read-only.
        [Display(Name = "Id")]
        public int ApiResourceId { get; set; }

        [Display(Name = "Name")]
        public string ApiResourceName { get; set; }
    }
}
