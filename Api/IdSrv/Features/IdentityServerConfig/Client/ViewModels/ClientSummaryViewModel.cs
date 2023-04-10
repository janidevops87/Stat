using System.ComponentModel.DataAnnotations;

namespace Statline.IdentityServer.Features.IdentityServerConfig.Client.ViewModels
{
    public class ClientSummaryViewModel
    {
        [Display(Name = "Name")]
        public string ClientName { get; set; }

        [Display(Name = "Client Id")]
        public string ClientId { get; set; }

        [Display(Name = "Id")]
        public int Id { get; set; }

        [Display(Name = "Tenant Id")]
        public int TenantId { get; set; }
    }
}
