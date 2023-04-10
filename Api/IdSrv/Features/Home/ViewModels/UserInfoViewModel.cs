using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Security.Claims;

namespace Statline.IdentityServer.Features.Home.ViewModels
{
    public class UserInfoViewModel
    {
        [Display(Name = "All claims")]
        public IEnumerable<Claim> Claims { get; set; }

        [Display(Name = "Statline claims")]
        public IEnumerable<Claim> StatlineClaims { get; set; }

        [Display(Name = "Roles")]
        public IEnumerable<string> Roles { get; set; }

        [Display(Name = "User ID")]
        public string Id { get; set; }

        [Display(Name = "User name")]
        public string Name { get; set; }

        [Display(Name = "Tenant ID")]
        public int TenantId { get; set; }

        [Display(Name = "Email")]
        public string Email { get; set; }

        [Display(Name = "First name")]
        public string FirstName { get; set; }

        [Display(Name = "Last name")]
        public string LastName { get; set; }

        [Display(Name = "Cookie properties")]
        public IEnumerable<KeyValuePair<string, string>> CookieProperties { get; set; }
    }
}
