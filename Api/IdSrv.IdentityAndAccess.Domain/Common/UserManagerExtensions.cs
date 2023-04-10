using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;
using Statline.Common.Utilities;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Command;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Common;

namespace Statline.IdentityServer.IdentityAndAccess.Domain.Common
{
    public static class UserManagerExtensions
    {
        public static async Task<User> GetById(
            this UserManager<User> userManager,
            UserId userId)
        {
            Check.NotNull(userManager, nameof(userManager));
            Check.NotNull(userId, nameof(userId));

            var user = await userManager.FindByIdAsync(userId);

            if (user == null)
            {
                throw new ArgumentException(
                    $"User with id '{userId}' wasn't found.", nameof(userId));
            }

            return user;
        }
    }
}
