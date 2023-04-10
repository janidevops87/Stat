using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using AutoMapper;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Options;
using Statline.Common.Domain.Events;
using Statline.Common.Utilities;
using Statline.IdentityServer.IdentityAndAccess.App.Common;
using Statline.IdentityServer.IdentityAndAccess.App.Users.Dto;
using Statline.IdentityServer.IdentityAndAccess.Domain.Common;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Command;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Command.Events;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Command.Services;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Common;

namespace Statline.IdentityServer.IdentityAndAccess.App.Users
{
    /// <dev>
    /// NOTE: This application service is kind of hybrid.
    /// On one hand, it uses <see cref="IUserRepository"/> to access 
    /// users directly. On the other hand, it delegates many operations to 
    /// ASP.NET Identity's <see cref="UserManager{User}"/>. I'm far not 
    /// happy with this approach: its ugly, and not always fluent and efficient.
    /// However, <see cref="UserManager{User}"/> implements many useful features
    /// which would require significant effort to implement ourselves.
    /// 
    /// So <see cref="UserManager{User}"/> is used where possible, and 
    /// <see cref="IUserRepository"/> otherwise (e.g. to list all users).
    /// </dev>
    public class UserManagementApplication
    {
        private readonly IUserRepository userRepository;
        private readonly IRoleRepository roleRepository;
        private readonly ITenantRepository tenantRepository;
        private readonly IMapper mapper;
        private readonly UserManager<User> userManager;
        private readonly IDomainEventPublisher domainEventPublisher;
        private readonly UserManagementApplicationOptions options;

        public UserManagementApplication(
            IUserRepository userRepository,
            IRoleRepository roleRepository,
            ITenantRepository tenantRepository,
            IMapper mapper,
            UserManager<User> userManager,
            IDomainEventPublisher domainEventPublisher,
            IOptions<UserManagementApplicationOptions> options)
        {
            Check.NotNull(userRepository, nameof(userRepository));
            Check.NotNull(roleRepository, nameof(roleRepository));
            Check.NotNull(tenantRepository, nameof(tenantRepository));
            Check.NotNull(mapper, nameof(mapper));
            Check.NotNull(userManager, nameof(userManager));
            Check.NotNull(domainEventPublisher, nameof(domainEventPublisher));
            Check.NotNull(options, nameof(options));

            this.userRepository = userRepository;
            this.roleRepository = roleRepository;
            this.tenantRepository = tenantRepository;
            this.mapper = mapper;
            this.userManager = userManager;
            this.domainEventPublisher = domainEventPublisher;
            this.options = options.Value;
            this.options.Validate(nameof(options));
        }


        // TODO: This method returns more than needed.
        public async Task<TenantUserSummaryInfo> GetUserSummaryByLoginInfoAsync(
            UserLoginInfo loginInfo)
        {
            Check.NotNull(loginInfo, nameof(loginInfo));

            var user = await userManager.FindByLoginAsync(
                loginInfo.LoginProvider,
                loginInfo.ProviderKey);

            return mapper.Map<TenantUserSummaryInfo>(user);
        }


        public async Task DeleteUserAsync(UserId userId)
        {
            Check.NotNull(userId, nameof(userId));

            var user = await userManager.GetById(userId);

            var result = await userManager.DeleteAsync(user);
            result.ThrowIfFailed();
        }

        public async Task ActivateUser(UserId userId)
        {
            Check.NotNull(userId, nameof(userId));

            var user = await userManager.GetById(userId);

            if (user.IsActive)
            {
                return;
            }

            user.Activate();

            await userManager.UpdateAsync(user);
        }

        public async Task DeactivateUser(UserId userId)
        {
            Check.NotNull(userId, nameof(userId));

            var user = await userManager.GetById(userId);

            if (!user.IsActive)
            {
                return;
            }

            user.Deactivate();

            await userManager.UpdateAsync(user);
        }

        public async Task<UserPartInfo<UserPropertiesInfo>> GetUserPropertiesAsync(UserId userId)
        {
            Check.NotNull(userId, nameof(userId));

            var user = await userManager.GetById(userId);

            var userProps = mapper.Map<UserPartInfo<UserPropertiesInfo>>(user);

            return userProps;
        }

        public async Task UpdateUserPropertiesAsync(UserId userId, UserPropertiesInfo propsInfo)
        {
            Check.NotNull(userId, nameof(userId));
            Check.NotNull(propsInfo, nameof(propsInfo));

            var user = await userManager.GetById(userId);

            // UserManager implements some security checks and normalization,
            // so instead of just updating the whole user entity we do it step-by-step.

            if (!string.Equals(propsInfo.UserName, user.UserName, StringComparison.Ordinal))
            {
                await userManager.SetUserNameAsync(user, propsInfo.UserName);
            }

            if (!string.Equals(propsInfo.Email, user.Email, StringComparison.Ordinal))
            {
                await userManager.SetEmailAsync(user, propsInfo.Email);
            }
        }

        public async Task RegisterNewUserWithExternalLoginAsync(
            NewUserInfo newUserInfo,
            UserLoginInfo externalLoginInfo)
        {
            Check.NotNull(newUserInfo, nameof(newUserInfo));
            Check.NotNull(externalLoginInfo, nameof(externalLoginInfo));

            var userRegistrationService = new UserRegistrationService(
                userRepository,
                tenantRepository,
                userManager,
                domainEventPublisher);

            var userRegInfo = new UserRegistrationInfo(
                newUserInfo.UserName,
                newUserInfo.Email,
                newUserInfo.FirstName,
                newUserInfo.LastName);

            await userRegistrationService.RegisterNewUserWithExternalLoginAsync(
                userRegInfo,
                externalLoginInfo);
        }

        public async Task RegisterNewUserWithLocalLoginAsync(
           NewLocalUserInfo newUserInfo)
        {
            Check.NotNull(newUserInfo, nameof(newUserInfo));
            
            var userRegistrationService = new UserRegistrationService(
                userRepository,
                tenantRepository,
                userManager,
                domainEventPublisher);

            var userRegInfo = new LocalUserRegistrationInfo(
                newUserInfo.UserName,
                newUserInfo.Password,
                newUserInfo.Email,
                newUserInfo.FirstName,
                newUserInfo.LastName);

            await userRegistrationService.RegisterNewUserWithLocalLoginAsync(
                userRegInfo);
        }

        public async Task ConfirmNewUserRegistrationAsync(
            UserId userId,
            TenantId targetTenantId)
        {
            Check.NotNull(userId, nameof(userId));
            Check.NotNull(targetTenantId, nameof(targetTenantId));

            var userRegistrationService = new UserRegistrationService(
                userRepository,
                tenantRepository,
                userManager,
                domainEventPublisher);

            await userRegistrationService.ConfirmNewUserRegistrationAsync(
                userId,
                targetTenantId);
        }


        public async Task<UserPartInfo<IEnumerable<ClaimInfo>>> GetUserClaimsAsync(
            UserId userId)
        {
            Check.NotNull(userId, nameof(userId));

            var user = await userManager.GetById(userId);
            var userClaims = await userManager.GetClaimsAsync(user);

            var claimInfo = mapper
                .Map<UserPartInfo<IEnumerable<ClaimInfo>>>(userClaims);
            mapper.Map(user, claimInfo);

            return claimInfo;
        }

        public async Task AddUserClaimAsync(UserId userId, ClaimInfo claimInfo)
        {
            Check.NotNull(userId, nameof(userId));
            Check.NotNull(claimInfo, nameof(claimInfo));

            var user = await userManager.GetById(userId);

            var claim = mapper.Map<System.Security.Claims.Claim>(claimInfo);

            var userClaims = await userManager.AddClaimAsync(user, claim);

            // TODO: Think how to move this to the domain layer.
            await domainEventPublisher.PublishAsync(
                new UserClaimAdded(userId, new Claim(claim.Type, claim.Value)));
        }

        public async Task DeleteUserClaimAsync(UserId userId, ClaimInfo claimInfo)
        {
            Check.NotNull(userId, nameof(userId));
            Check.NotNull(claimInfo, nameof(claimInfo));

            var user = await userManager.GetById(userId);

            var claim = mapper.Map<System.Security.Claims.Claim>(claimInfo);

            var userClaims = await userManager.RemoveClaimAsync(user, claim);

            // TODO: Think how to move this to the domain layer.
            await domainEventPublisher.PublishAsync(
                new UserClaimRemoved(userId, new Claim(claim.Type, claim.Value)));
        }

        public async Task<IEnumerable<RoleInfo>> ListUserCandidateRolesAsync(
            UserId userId)
        {
            Check.NotNull(userId, nameof(userId));

            var user = await userManager.GetById(userId);
            var userRoles = await userManager.GetRolesAsync(user);

            // We don't expect too many roles(at least for now it's 2-3),
            // so don't bother with storage-level filtering, do this
            // in the app's code.
            var roles = new HashSet<Role> { await roleRepository.ListRolesAsync() };

            roles.RemoveWhere(role => userRoles.Contains(role.Name));

            return mapper.Map<IEnumerable<RoleInfo>>(roles);
        }

        public async Task<UserPartInfo<IEnumerable<RoleInfo>>>
            GetUserRolesAsync(UserId userId)
        {
            Check.NotNull(userId, nameof(userId));

            var user = await userManager.GetById(userId);
            var userRoles = await userManager.GetRolesAsync(user);

            var roleInfo = mapper
                .Map<UserPartInfo<IEnumerable<RoleInfo>>>(userRoles);
            mapper.Map(user, roleInfo);

            return roleInfo;
        }

        public async Task AddUserToRoleAsync(
            UserId userId,
            RoleInfo roleInfo)
        {
            Check.NotNull(userId, nameof(userId));
            Check.NotNull(roleInfo, nameof(roleInfo));

            var user = await userManager.GetById(userId);

            var result = await userManager.AddToRoleAsync(user, roleInfo.Name);
            result.ThrowIfFailed();
        }

        public async Task RemoveUserFromRoleAsync(
            UserId userId,
            RoleInfo roleInfo)
        {
            Check.NotNull(userId, nameof(userId));
            Check.NotNull(roleInfo, nameof(roleInfo));

            var user = await userManager.GetById(userId);

            var result = await userManager.RemoveFromRoleAsync(user, roleInfo.Name);
            result.ThrowIfFailed();
        }
    }
}
