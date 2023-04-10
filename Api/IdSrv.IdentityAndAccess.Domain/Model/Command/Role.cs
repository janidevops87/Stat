using System;
using System.Collections.Generic;
using System.Text;
using Microsoft.AspNetCore.Identity;

namespace Statline.IdentityServer.IdentityAndAccess.Domain.Model.Command
{
    /// <dev>
    /// Currently, Role is not associated with Tenant.
    /// In other words, roles are global and more
    /// intended for internal administration tasks,
    /// since customers can't have their own roles.
    /// If wider roles functionality is needed,
    /// the class should be extended with multi-tenancy
    /// support.
    /// </dev>
    public class Role : IdentityRole
    {
        public Role(string roleName) : base(roleName)
        {
        }

        private Role() { }
    }
}
