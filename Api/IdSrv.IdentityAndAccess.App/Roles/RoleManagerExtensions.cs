using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;
using Statline.Common.Utilities;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Command;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Common;

namespace Statline.IdentityServer.IdentityAndAccess.App.Roles
{
    internal static class RoleManagerExtensions
    {
        public static async Task<Role> GetById(
            this RoleManager<Role> roleManager,
            RoleId roleId)
        {
            Check.NotNull(roleManager, nameof(roleManager));
            Check.NotNull(roleId, nameof(roleId));

            var role = await roleManager.FindByIdAsync(roleId);

            if (role == null)
            {
                throw new ArgumentException(
                    $"Role with id '{roleId}' wasn't found.", nameof(roleId));
            }

            return role;
        }
    }
}
