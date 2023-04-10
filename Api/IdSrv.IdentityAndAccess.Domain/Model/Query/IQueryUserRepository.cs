using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Common;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Statline.IdentityServer.IdentityAndAccess.Domain.Model.Query
{
    public interface IQueryUserRepository
    {
        Task<IEnumerable<TenantUserInfo>> ListUsersAsync();
        Task<TenantUserInfo> FindTenantUserByIdAsync(UserId userId);
        Task<UserInfo> FindUserByIdAsync(UserId userId);
    }
}
