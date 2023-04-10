using System.Collections.Generic;
using System.Threading.Tasks;
using AutoMapper;
using Statline.Common.Utilities;
using Statline.IdentityServer.IdentityAndAccess.App.Users.Dto;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Common;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Query;

namespace Statline.IdentityServer.IdentityAndAccess.App.Users
{
    public class UserQueryApplication
    {
        private readonly IQueryUserRepository userQueryRepository;
        private readonly IMapper mapper;
   
        public UserQueryApplication(
            IQueryUserRepository userQueryRepository,
            IMapper mapper)
        {
            Check.NotNull(userQueryRepository, nameof(userQueryRepository));
            Check.NotNull(mapper, nameof(mapper));

            this.userQueryRepository = userQueryRepository;
            this.mapper = mapper;
        }

        public async Task<IEnumerable<UserListSummaryInfo>> ListUsersAsync()
        {
            var users = await userQueryRepository.ListUsersAsync();
            return mapper.Map<IEnumerable<UserListSummaryInfo>>(users);
        }

        public async Task<TenantUserSummaryInfo> GetTenantUserSummaryAsync(UserId userId)
        {
            Check.NotNull(userId, nameof(userId));

            var user = await userQueryRepository.GetTenantUserById(userId);

            var userSummary = mapper.Map<TenantUserSummaryInfo>(user);

            return userSummary;
        }

        public async Task<UserSummaryInfo> GetUserSummaryAsync(UserId userId)
        {
            Check.NotNull(userId, nameof(userId));

            var user = await userQueryRepository.GetUserById(userId);

            var userSummary = mapper.Map<UserSummaryInfo>(user);

            return userSummary;
        }
    }
}
