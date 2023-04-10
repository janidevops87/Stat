using Statline.IdentityServer.Features.IdentityAndAccess.User.ViewModels;
using System.ComponentModel.DataAnnotations;

namespace Statline.IdentityServer.Features.IdentityAndAccess.User.ViewModels
{
    public class EditClaimsViewModel : UserViewModel
    {
        [Display(Name = "Claims")]
        public ClaimViewModel[] Claims { get; set; }
    }
}