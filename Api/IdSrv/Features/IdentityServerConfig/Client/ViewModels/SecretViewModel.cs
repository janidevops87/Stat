using System;
using System.ComponentModel.DataAnnotations;
using static IdentityServer4.IdentityServerConstants;

namespace Statline.IdentityServer.Features.IdentityServerConfig.Client.ViewModels
{
    public class SecretViewModel : ClientViewModel
    {
        [Display(Name = "Type")]
        [Required]
        [StringLength(250)]
        public string Type { get; set; } = SecretTypes.SharedSecret;

        [Display(Name = "Value")]
        [Required]
        [StringLength(2000)]
        public string Value { get; set; }

        [Display(Name = "Creation time (GMT)")]
        public DateTimeOffset CreationTime { get; set; }
    }
}
