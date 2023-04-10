using System;
using System.Threading.Tasks;
using Statline.Common.Utilities;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Command;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Common;

namespace Statline.IdentityServer.IdentityAndAccess.App.Users
{
    internal static class UserRepositoryExtensions
    {
        public static async Task<User> GetById(
            this IUserRepository userRepository,
            UserId userId)
        {
            Check.NotNull(userId, nameof(userId));

            var user = await userRepository.FindByIdAsync(userId);

            if (user == null)
            {
                throw new ArgumentException(
                    $"User with id '{userId}' wasn't found.", nameof(userId));
            }

            return user;
        }
    }
}
