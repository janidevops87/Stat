using Microsoft.AspNetCore.Identity;
using Statline.Common.Domain.Events;
using Statline.Common.Utilities;
using Statline.IdentityServer.IdentityAndAccess.Domain.Common;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Command.Events;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Common;
using System;
using System.Threading.Tasks;

namespace Statline.IdentityServer.IdentityAndAccess.Domain.Model.Command.Services
{
    public sealed class UserRegistrationService
    {
        private readonly IUserRepository userRepository;
        private readonly ITenantRepository tenantRepository;
        private readonly UserManager<User> userManager;
        private readonly IDomainEventPublisher domainEventPublisher;

        public UserRegistrationService(
            IUserRepository userRepository,
            ITenantRepository tenantRepository,
            UserManager<User> userManager,
            IDomainEventPublisher domainEventPublisher)
        {
            Check.NotNull(userRepository, nameof(userRepository));
            Check.NotNull(tenantRepository, nameof(tenantRepository));
            Check.NotNull(userManager, nameof(userManager));
            Check.NotNull(domainEventPublisher, nameof(domainEventPublisher));

            this.userRepository = userRepository;
            this.tenantRepository = tenantRepository;
            this.userManager = userManager;
            this.domainEventPublisher = domainEventPublisher;
        }

        public async Task<UserId> RegisterNewUserWithExternalLoginAsync(
            UserRegistrationInfo newUserInfo,
            UserLoginInfo externalLoginInfo)
        {
            Check.NotNull(newUserInfo, nameof(newUserInfo));
            Check.NotNull(externalLoginInfo, nameof(externalLoginInfo));

            // Initially create the user without assigning a tenant.
            // Before allowing to activate him we should assign 
            // him to a tenant.
            var newUser = new User(newUserInfo.UserName)
            {
                Email = newUserInfo.Email,
                FirstName = newUserInfo.FirstName,
                LastName = newUserInfo.LastName,
            };

            IdentityResult result = await userManager.CreateAsync(newUser);
            result.ThrowIfFailed();

            result = await userManager.AddLoginAsync(newUser, externalLoginInfo);
            result.ThrowIfFailed();

            return newUser.Id;
        }

        public async Task<UserId> RegisterNewUserWithLocalLoginAsync(
            LocalUserRegistrationInfo newUserInfo)
        {
            Check.NotNull(newUserInfo, nameof(newUserInfo));
            
            // Initially create the user without assigning a tenant.
            // Before allowing to activate him we should assign 
            // him to a tenant.
            var newUser = new User(newUserInfo.UserName)
            {
                Email = newUserInfo.Email,
                FirstName = newUserInfo.FirstName,
                LastName = newUserInfo.LastName,
            };

            IdentityResult result = await userManager.CreateAsync(
                newUser, 
                newUserInfo.Password);
            result.ThrowIfFailed();

            return newUser.Id;
        }

        public async Task ConfirmNewUserRegistrationAsync(
            UserId userId,
            TenantId targetTenantId)
        {
            Check.NotNull(userId, nameof(userId));
            Check.NotNull(targetTenantId, nameof(targetTenantId));

            var user = await userManager.GetById(userId);

            EnsureUserNotConfirmed(user);

            var targetTenant = await tenantRepository.GetByIdAsync(targetTenantId);

            targetTenant.RegisterUser(user);

            user.Activate();

            var result = await userManager.UpdateAsync(user);
            result.ThrowIfFailed();

            await domainEventPublisher.PublishAsync(
                new UserRegistrationConfirmed(
                    user.TenantId,
                    user.Id,
                    user.Email));
        }

        private static void EnsureUserNotConfirmed(User user)
        {
            if (user.IsConfirmed)
            {
                throw new InvalidOperationException(
                    $"The user with id '{user.Id}' is already " +
                    $"confirmed and registered in tenant with " +
                    $"id '{user.TenantId}'.");
            }
        }
    }
}
