using Statline.IdentityServer.Helper;
using System;
using System.ComponentModel.DataAnnotations;

namespace Statline.IdentityServer.Features.IdentityServerConfig.Client.ViewModels
{
    public class RedirectUriViewModel : ClientViewModel
    {
        [Required]
        [Display(Name = "Redirect Uri")]
        [RelaxedUrl]
        public Uri Value { get; set; } 
    }
}
    