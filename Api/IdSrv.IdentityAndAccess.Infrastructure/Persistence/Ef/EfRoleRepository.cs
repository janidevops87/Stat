using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Statline.Common.Infrastructure.Domain.Repository;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Command;

namespace Statline.IdentityServer.IdentityAndAccess.Infrastructure.Persistence.Ef
{
    public class EfRoleRepository :
        RepositoryBase<IdentityAndAccessDbContext>,
        IRoleRepository
    {

        public EfRoleRepository(IdentityAndAccessDbContext dbContext)
            : base(dbContext)
        {
        }

        public async Task<IEnumerable<Role>> ListRolesAsync()
        {
            return await DbContext
                .Roles
                .OrderBy(r => r.Name)
                .ToArrayAsync().ConfigureAwait(false);
        }
    }
}
