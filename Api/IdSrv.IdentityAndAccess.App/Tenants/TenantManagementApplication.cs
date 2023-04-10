using System.Collections.Generic;
using System.Threading.Tasks;
using AutoMapper;
using Statline.Common.Utilities;
using Statline.IdentityServer.IdentityAndAccess.App.Tenants.Dto;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Command;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Common;

namespace Statline.IdentityServer.IdentityAndAccess.App.Tenants
{
    public class TenantManagementApplication
    {
        private readonly ITenantRepository tenantRepository;
        private readonly IMapper mapper;

        public TenantManagementApplication(
            ITenantRepository tenantRepository,
            IMapper mapper)
        {
            Check.NotNull(tenantRepository, nameof(tenantRepository));
            Check.NotNull(mapper, nameof(mapper));

            this.tenantRepository = tenantRepository;
            this.mapper = mapper;
        }

        public async Task<TenantId> GetTenantIdByOrganizationNameAsync(string organizationName)
        {
            Check.NotEmpty(organizationName, nameof(organizationName));
            var tenant = await tenantRepository.FindByOrganizationNameAsync(organizationName);
            return tenant.Id;
        }

        public async Task<TenantSummaryInfo> GetTenantSummaryAsync(TenantId tenantId)
        {
            Check.NotNull(tenantId, nameof(tenantId));
            var tenant = await tenantRepository.GetByIdAsync(tenantId);
            return mapper.Map<TenantSummaryInfo>(tenant);
        }

        public async Task<IEnumerable<TenantListSummaryInfo>> ListTenantsAsync()
        {
            var tenants = await tenantRepository.ListTenantsAsync();
            return mapper.Map<IEnumerable<TenantListSummaryInfo>>(tenants);
        }

        public async Task<TenantId> CreateTenantAsync(NewTenantInfo newTenantInfo)
        {
            Check.NotNull(newTenantInfo, nameof(newTenantInfo));

            var newTenant = mapper.Map<Tenant>(newTenantInfo);

            tenantRepository.AddTenant(newTenant);

            await tenantRepository.SaveChangesAsync();

            return newTenant.Id;
        }

        public async Task DeleteTenantAsync(TenantId tenantId)
        {
            Check.NotNull(tenantId, nameof(tenantId));

            tenantRepository.DeleteTenant(tenantId);

            await tenantRepository.SaveChangesAsync();
        }

        public async Task<TenantPartInfo<TenantPropertiesInfo>>
            GetTenantPropertiesAsync(TenantId tenantId)
        {
            Check.NotNull(tenantId, nameof(tenantId));

            var tenant = await tenantRepository.GetByIdAsync(tenantId);

            var propsInfo = mapper.Map<TenantPartInfo<TenantPropertiesInfo>>(tenant);

            return propsInfo;
        }

        public async Task UpdateTenantPropertiesAsync(
            TenantId tenantId, TenantPropertiesInfo propsInfo)
        {
            Check.NotNull(tenantId, nameof(tenantId));
            Check.NotNull(propsInfo, nameof(propsInfo));

            var tenant = await tenantRepository.GetByIdAsync(tenantId);

            mapper.Map(propsInfo, tenant);

            await tenantRepository.SaveChangesAsync();
        }

        public async Task<TenantPartInfo<IEnumerable<ClaimInfo>>> GetTenantClaimsAsync(
            TenantId tenantId)
        {
            Check.NotNull(tenantId, nameof(tenantId));

            var tenant = await tenantRepository.GetByIdAsync(tenantId);

            var claimInfo = mapper
                .Map<TenantPartInfo<IEnumerable<ClaimInfo>>>(tenant.UserClaims);

            mapper.Map(tenant, claimInfo);

            return claimInfo;
        }

        public async Task AddTenantClaimAsync(TenantId tenantId, ClaimInfo claimInfo)
        {
            Check.NotNull(tenantId, nameof(tenantId));
            Check.NotNull(claimInfo, nameof(claimInfo));

            var claim = mapper.Map<Claim>(claimInfo);

            var tenant = await tenantRepository.GetByIdAsync(tenantId);

            tenant.AddUserClaim(claim);

            await tenantRepository.SaveChangesAsync();
        }

        public async Task DeleteTenantClaimAsync(TenantId tenantId, ClaimInfo claimInfo)
        {
            Check.NotNull(tenantId, nameof(tenantId));
            Check.NotNull(claimInfo, nameof(claimInfo));

            var claim = mapper.Map<Claim>(claimInfo);

            var tenant = await tenantRepository.GetByIdAsync(tenantId);

            tenant.RemoveUserClaim(claim);

            await tenantRepository.SaveChangesAsync();
        }

    }
}
