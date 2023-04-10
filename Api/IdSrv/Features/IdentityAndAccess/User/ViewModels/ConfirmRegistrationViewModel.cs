using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Statline.IdentityServer.Features.IdentityAndAccess.User.ViewModels
{
    public class ConfirmRegistrationViewModel : UserViewModel
    {
        public SelectTenantViewModel Tenant { get; } = new SelectTenantViewModel();
    }
}
