using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace Statline.IdentityServer.Features.IdentityServerConfig.Client.ViewModels
{
    public class ClientViewModel
    {
        // This property is intended to be logically read-only.
        [Display(Name = "Client Id")]
        public string ClientId { get; set; }

        [Display(Name = "Id")]
        public int Id { get; set; }
    }
}
