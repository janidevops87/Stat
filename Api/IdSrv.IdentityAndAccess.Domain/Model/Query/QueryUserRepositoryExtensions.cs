using Statline.Common.Utilities;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Common;
using System;
using System.Threading.Tasks;

namespace Statline.IdentityServer.IdentityAndAccess.Domain.Model.Query
{
    public static class QueryUserRepositoryExtensions
    {
        public static async Task<TenantUserInfo> GetTenantUserById(
            this IQueryUserRepository repository,
            UserId userId)
        {
            Check.NotNull(userId, nameof(userId));

            var user = await repository.FindTenantUserByIdAsync(userId);

            EnureUserFound(user, userId);

            return user;
        }

        public static async Task<UserInfo> GetUserById(
            this IQueryUserRepository repository,
            UserId userId)
        {
            Check.NotNull(userId, nameof(userId));

            var user = await repository.FindUserByIdAsync(userId);

            EnureUserFound(user, userId);

            return user;
        }

        private static void EnureUserFound(UserInfo user, UserId userId)
        {
            if (user == null)
            {
                throw new ArgumentException(
                    $"User with id '{userId}' wasn't found.", nameof(userId));
            }
        }
    }
}
