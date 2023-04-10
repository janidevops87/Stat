using System.Collections.Generic;
using System.Globalization;
using System.Security.Claims;
using System.Threading.Tasks;
using AutoMapper;
using IdentityModel;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Options;
using Statline.Common.Utilities;
using Statline.IdentityServer.IdentityAndAccess.App.Tenants;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Command;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Common;

namespace Statline.IdentityServer.Common.Security

{
    // Sample: https://github.com/Microsoft/BikeSharing360_Websites/blob/90e19f5405cf75c38992b3752189dc60e922cd05/PrivateWebSite/src/BikeSharing_Private_Web_Site/Startup.cs#L65
    public class UserClaimsPrincipalFactory : UserClaimsPrincipalFactory<User, Role>
    {
        private readonly TenantManagementApplication tenantManagementApplication;
        private readonly IMapper mapper;

        public UserClaimsPrincipalFactory(
            UserManager<User> userManager,
            RoleManager<Role> roleManager,
            IOptions<IdentityOptions> optionsAccessor,
            TenantManagementApplication tenantManagementApplication,
            IMapper mapper)
            : base(userManager, roleManager, optionsAccessor)
        {
            Check.NotNull(tenantManagementApplication, nameof(tenantManagementApplication));
            Check.NotNull(mapper, nameof(mapper));
            this.tenantManagementApplication = tenantManagementApplication;
            this.mapper = mapper;
        }

        public async override Task<ClaimsPrincipal> CreateAsync(User user)
        {
            Check.NotNull(user, nameof(user));

            var principal = await base.CreateAsync(user);

            var claimsIdentity = ((ClaimsIdentity)principal.Identity);

            var userClaims = GetAdditionalUserClaims(user);

            claimsIdentity.AddClaims(userClaims);

            var tenantClaims = await GetTenantClaimsAsync(user.TenantId);

            claimsIdentity.AddClaims(tenantClaims);

            return principal;
        }

        private static IEnumerable<System.Security.Claims.Claim>
            GetAdditionalUserClaims(User user)
        {
            // Here we translate some properties of the User to claims
            // (in addition to explicitly defined claims).
            if (user.TenantId.HasValue)
            {
                yield return new System.Security.Claims.Claim(
                                StatlineClaimTypes.TenantIdClaim,
                                user.TenantId.Value.ToString(CultureInfo.InvariantCulture));
            }

            if (!string.IsNullOrEmpty(user.FirstName))
            {
                yield return new System.Security.Claims.Claim(
                                JwtClaimTypes.GivenName,
                                user.FirstName);
            }

            if (!string.IsNullOrEmpty(user.LastName))
            {
                yield return new System.Security.Claims.Claim(
                                JwtClaimTypes.FamilyName,
                                user.LastName);
            }
            // Add more claims if needed.
        }

        private async Task<IEnumerable<System.Security.Claims.Claim>>
            GetTenantClaimsAsync(TenantId tenantId)
        {
            var tenantClaimsInfo = await tenantManagementApplication.GetTenantClaimsAsync(
                tenantId);

            var tenantClaims = mapper.Map<IEnumerable<System.Security.Claims.Claim>>(
                tenantClaimsInfo.PartInfo);

            return tenantClaims;
        }
    }
}
