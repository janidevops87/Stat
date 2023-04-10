using System.ComponentModel.DataAnnotations;

namespace Statline.IdentityServer.Features.IdentityServerConfig.Client.ViewModels
{
    public class EditPropertiesViewModel : ClientViewModel
    {
        [Required]
        [StringLength(200)]
        [Display(Name = "Client Id")]
        public string EditableClientId { get; set; }

        [Required]
        [StringLength(200)]
        [Display(Name = "Client Name")]
        public string ClientName { get; set; }

        [Required]
        [Display(Name = "Allowed Grant Types")]
        public EditGrantTypesViewModel GrantTypes { get; }
            = new EditGrantTypesViewModel();

        [Display(Name = "Client Claims Prefix")]
        [StringLength(200)]
        public string ClientClaimsPrefix { get; set; }

        [Display(Name = "Access Token Lifetime")]
        [Range(1, int.MaxValue)]
        public int AccessTokenLifetime { get; set; }

        [Required]
        [Display(Name = "Always send client claims")]
        public bool AlwaysSendClientClaims { get; set; }

        [Required]
        [Display(Name = "Always include user claims in id token")]
        public bool AlwaysIncludeUserClaimsInIdToken { get; set; }

        [Required]
        [Display(Name = "Allow access tokens via browser")]
        public bool AllowAccessTokensViaBrowser { get; set; }

        [Required]
        [Display(Name = "Require consent")]
        public bool RequireConsent { get; set; }

        [Required]
        [Display(Name = "Allow offline access")]
        public bool AllowOfflineAccess { get; set; }
    }
}
