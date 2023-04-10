using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Statline.Common.Infrastructure.Domain.Repository;
using Statline.Common.Utilities;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Common;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Query;

namespace Statline.IdentityServer.IdentityAndAccess.Infrastructure.Persistence.Ef
{
    public class EfQueryUserRepository :
        RepositoryBase<IdentityAndAccessDbContext>,
        IQueryUserRepository
    {
        public EfQueryUserRepository(IdentityAndAccessDbContext dbContext)
            : base(dbContext)
        {
        }

        public async Task<IEnumerable<TenantUserInfo>> ListUsersAsync()
        {
            var query = GetTenantUserInfoQuery();

            return await query
                .OrderBy(u => u.UserName)
                .ToArrayAsync().ConfigureAwait(false);
        }

        public async Task<TenantUserInfo> FindTenantUserByIdAsync(UserId userId)
        {
            Check.NotNull(userId, nameof(userId));

            var query = GetTenantUserInfoQuery();

            return await query
                .SingleOrDefaultAsync(u => u.Id == userId.Value)
                .ConfigureAwait(false);
        }

        public async Task<UserInfo> FindUserByIdAsync(UserId userId)
        {
            Check.NotNull(userId, nameof(userId));

            // TODO: Use mapper.
            var query = 
                from u in DbContext.Users.AsNoTracking()
                where u.Id == userId.Value
                select new UserInfo
                {
                    Id = u.Id,
                    UserName = u.UserName,
                    Email = u.Email,
                    IsActive = u.IsActive,
                    IsConfirmed = u.IsConfirmed,
                    TenantId = u.TenantId,
                };

            return await query.SingleOrDefaultAsync().ConfigureAwait(false);
        }

        // Originally I wanted to implement
        // this using EF Query Types and a defining query.
        // However, with that approach EF wasn't able to translate
        // sub-queries to be executed at SQL Server side.
        // I filed a bug for this here: 
        // https://github.com/aspnet/EntityFrameworkCore/issues/12763.
        private IQueryable<TenantUserInfo> GetTenantUserInfoQuery()
        {
            return from u in DbContext.Users.AsNoTracking()
                   join t in DbContext.Tenants.AsNoTracking()
                   // This is how left join is done in LINQ
                   on u.TenantId equals t.Id into tenantsGroups
                   from tenant in tenantsGroups.DefaultIfEmpty()
                   select new TenantUserInfo
                   {
                       Id = u.Id,
                       UserName = u.UserName,
                       Email = u.Email,
                       IsActive = u.IsActive,
                       IsConfirmed = u.IsConfirmed,
                       TenantId = u.TenantId,
                       TenantOrganizationName = tenant.OrganizationName
                   };
        }
    }
}
