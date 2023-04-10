using System.Collections.Generic;
using System.Threading.Tasks;

namespace Statline.IdentityServer.IdentityAndAccess.Domain.Model.Command
{
    public interface IRoleRepository
    {
        Task<IEnumerable<Role>> ListRolesAsync();
        // TODO: Move to another interface.
        Task SaveChangesAsync();
    }
}
