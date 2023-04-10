using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using Statline.Common.Infrastructure.Domain.Repository;
using Statline.Common.Utilities;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Command;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Common;

namespace Statline.IdentityServer.IdentityAndAccess.Infrastructure.Persistence.Ef
{
    public class EfUserRepository :
        RepositoryBase<IdentityAndAccessDbContext>,
        IUserRepository
    {
        private readonly UserStore<User, Role, IdentityAndAccessDbContext> userStore;

        public EfUserRepository(IdentityAndAccessDbContext dbContext)
            : base(dbContext)
        {
            this.userStore = 
                new UserStore<User, Role, IdentityAndAccessDbContext>(dbContext);
        }

        public async Task<IEnumerable<User>> ListUsersAsync()
        {
            return await DbContext
                .Users
                .OrderBy(u => u.UserName)
                .ToArrayAsync().ConfigureAwait(false);
        }

        public async Task<User> FindByIdAsync(UserId userId)
        {
            Check.NotNull(userId, nameof(userId));
            return await DbContext.Users.FindAsync(userId.Value).ConfigureAwait(false);
        }
    }
}
