using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Statline.Common.Domain.Events;
using Statline.Common.Utilities;
using Statline.IdentityServer.IdentityAndAccess.App.Common;
using Statline.IdentityServer.IdentityAndAccess.Domain.Common;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Command;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Command.Services;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Common;

namespace Statline.IdentityServer.IdentityAndAccess.App.Bootstrap
{
    public class BootstrapApplication
    {
        private readonly IUserRepository userRepository;
        private readonly ITenantRepository tenantRepository;
        private readonly UserManager<User> userManager;
        private readonly RoleManager<Role> roleManager;
        private readonly IDomainEventPublisher domainEventPublisher;
        private readonly ILogger logger;
        private readonly BootstrapApplicationOptions options;

        public BootstrapApplication(
            IUserRepository userRepository,
            ITenantRepository tenantRepository,
            IDomainEventPublisher domainEventPublisher,
            UserManager<User> userManager,
            RoleManager<Role> roleManager,
            ILogger<BootstrapApplication> logger,
            IOptions<BootstrapApplicationOptions> options)
        {
            Check.NotNull(userRepository, nameof(userRepository));
            Check.NotNull(tenantRepository, nameof(tenantRepository));
            Check.NotNull(userManager, nameof(userManager));
            Check.NotNull(roleManager, nameof(roleManager));
            Check.NotNull(domainEventPublisher, nameof(domainEventPublisher));
            Check.NotNull(logger, nameof(logger));

            this.userRepository = userRepository;
            this.tenantRepository = tenantRepository;
            this.userManager = userManager;
            this.roleManager = roleManager;
            this.logger = logger;
            this.domainEventPublisher = domainEventPublisher;
            this.options = options.Value;
            this.options.Validate(nameof(options));
        }

        public async Task ProvisionInitialConfigurationAsync()
        {
            logger.LogAppBootstrappedCheck();

            var adminTenantOrganizationName = 
                options.AdministrativeTenantOrganizationName;

            if (await tenantRepository.ExistsWithOrganizationNameAsync(
                adminTenantOrganizationName))
            {
                logger.LogAppAlreadyBootstrapped();
                return;
            }

            logger.LogCreatingTenant(adminTenantOrganizationName);

            // It would be nice to put this into a single transaction,
            // but we use EF retry execution strategy which is incompatible
            // with user-initiated transactions.
            // TODO: Investigate if it's possible to easily switch EF execution strategy.
            var adminTenantId = await CreateTenantAsync(
                adminTenantOrganizationName);

            var adminUserName = options.DefaultAdminUserName;

            logger.LogCreatingUser(adminUserName);
            var localAdminUserId = await RegisterAndConfirmNewUserWithLocalLoginAsync(
                adminUserName,
                password: options.DefaultAdminPassword,
                email: options.DefaultAdminEmail,
                targetTenantId: adminTenantId);

            logger.LogCreatingRole(WellKnownRoles.StatlineAdmin);
            await CreateRoleAsync(WellKnownRoles.StatlineAdmin);

            logger.LogCreatingRole(WellKnownRoles.CustomerAdmin);
            await CreateRoleAsync(WellKnownRoles.CustomerAdmin);

            logger.LogAddingUserToRole(adminUserName, WellKnownRoles.StatlineAdmin);
            await AddUserToRoleAsync(localAdminUserId, WellKnownRoles.StatlineAdmin);

            logger.LogAppBootstrapFinished();
        }

        private async Task<UserId> RegisterAndConfirmNewUserWithLocalLoginAsync(
            string userName,
            string password,
            string email,
            TenantId targetTenantId)
        {
            var userRegistrationService = new UserRegistrationService(
                userRepository,
                tenantRepository,
                userManager,
                domainEventPublisher);

            var userRegInfo = new LocalUserRegistrationInfo(
                userName,
                password,
                email,
                firstName: null,
                lastName: null);

            var userId = await userRegistrationService.RegisterNewUserWithLocalLoginAsync(
                userRegInfo);

            await userRegistrationService.ConfirmNewUserRegistrationAsync(
                userId,
                targetTenantId);

            return userId;
        }

        private async Task<TenantId> CreateTenantAsync(
            string organizationName)
        {
            var newTenant = new Tenant(id: null, organizationName);

            tenantRepository.AddTenant(newTenant);

            await tenantRepository.SaveChangesAsync();

            return newTenant.Id;
        }

        private async Task<RoleId> CreateRoleAsync(
            string roleName)
        {
            var newRole = new Role(roleName);

            var result = await roleManager.CreateAsync(newRole);
            result.ThrowIfFailed();

            return newRole.Id;
        }


        private async Task AddUserToRoleAsync(
            UserId userId,
            string roleName)
        {
            var user = await userManager.GetById(userId);

            var result = await userManager.AddToRoleAsync(user, roleName);
            result.ThrowIfFailed();
        }
    }
}
