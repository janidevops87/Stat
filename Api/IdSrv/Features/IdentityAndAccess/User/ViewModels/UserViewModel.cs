using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace Statline.IdentityServer.Features.IdentityAndAccess.User.ViewModels
{
    public class UserViewModel
    {
        // This property is intended to be logically read-only.
        [Display(Name = "User Name")]
        public string UserName { get; set; }

        [Display(Name = "Id")]
        public string Id { get; set; }
    }
}
