using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Common;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Statline.IdentityServer.IdentityAndAccess.Domain.Model.Command
{
    public interface IUserRepository
    {
        Task<IEnumerable<User>> ListUsersAsync();
        Task<User> FindByIdAsync(UserId userId);
        // TODO: Move to another interface.
        Task SaveChangesAsync();
    }
}
