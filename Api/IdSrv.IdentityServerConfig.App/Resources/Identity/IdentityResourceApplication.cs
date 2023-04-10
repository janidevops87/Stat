using System.Collections.Generic;
using System.Threading.Tasks;
using AutoMapper;
using IdentityServer4.EntityFramework.Entities;
using Statline.Common.Utilities;
using Statline.IdentityServer.IdentityServerConfig.App.Resources.Identity.Dto;
using Statline.IdentityServer.IdentityServerConfig.App.Resources.Shared.Dto;
using Statline.IdentityServer.IdentityServerConfig.Domain.Model;

namespace Statline.IdentityServer.IdentityServerConfig.App.Resources.Identity
{
    public class IdentityResourceApplication
    {
        private readonly IIdentityResourceRepository identityResourceRepository;
        private readonly IMapper mapper;

        public IdentityResourceApplication(
            IIdentityResourceRepository identityResourceRepository,
            IMapper mapper)
        {
            Check.NotNull(identityResourceRepository, nameof(identityResourceRepository));
            Check.NotNull(mapper, nameof(mapper));

            this.identityResourceRepository = identityResourceRepository;
            this.mapper = mapper;
        }

        #region IdentityResource

        public async Task<IEnumerable<IdentityResourceSummaryInfo>> ListIdentityResourcesAsync()
        {
            var identityResources = await identityResourceRepository.ListIdentityResourcesAsync();

            return mapper.Map<IEnumerable<IdentityResourceSummaryInfo>>(identityResources);
        }

        public async Task<IdentityResourceSummaryInfo> GetIdentityResourceSummaryAsync(int identityResourceId)
        {
            CheckId(identityResourceId);

            var identityResource = await identityResourceRepository.GetById(identityResourceId);

            return mapper.Map<IdentityResourceSummaryInfo>(identityResource);
        }

        public async Task<int> CreateIdentityResourceAsync(NewIdentityResourceInfo newIdentityResourceInfo)
        {
            Check.NotNull(newIdentityResourceInfo, nameof(newIdentityResourceInfo));

            var newIdentityResource = mapper.Map<IdentityResource>(newIdentityResourceInfo);

            identityResourceRepository.AddIdentityResource(newIdentityResource);

            await identityResourceRepository.SaveChangesAsync();

            return newIdentityResource.Id;
        }

        public async Task DeleteIdentityResourceAsync(int identityResourceId)
        {
            CheckId(identityResourceId);

            identityResourceRepository.DeleteIdentityResource(identityResourceId);

            await identityResourceRepository.SaveChangesAsync();
        }

        #endregion IdentityResource

        #region Properties

        public async Task<IdentityResourcePropertiesInfo> GetIdentityResourcePropertiesAsync(
            int identityResourceId)
        {
            CheckId(identityResourceId);

            var identityResource = await identityResourceRepository.GetById(identityResourceId);

            return mapper.Map<IdentityResourcePropertiesInfo>(identityResource);
        }

        public async Task UpdateIdentityResourcePropertiesAsync(
            int identityResourceId,
            IdentityResourcePropertiesInfo identityResourceProperties)
        {
            CheckId(identityResourceId);
            Check.NotNull(identityResourceProperties, nameof(identityResourceProperties));

            IdentityResource identityResource = await identityResourceRepository.GetById(identityResourceId);

            mapper.Map(identityResourceProperties, identityResource);

            await identityResourceRepository.SaveChangesAsync();
        }

        #endregion Properties

        #region UserClaims

        public async Task<IdentityResourcePartInfo<IEnumerable<UserClaimInfo>>>
            GetIdentityResourceUserClaimsAsync(int identityResourceId)
        {
            CheckId(identityResourceId);

            var identityResource = await identityResourceRepository.GetById(identityResourceId);

            return mapper.Map<IdentityResourcePartInfo<IEnumerable<UserClaimInfo>>>(
                identityResource);
        }

        public async Task AddIdentityResourceUserClaimAsync(
            int identityResourceId,
            UserClaimInfo claimInfo)
        {
            CheckId(identityResourceId);
            Check.NotNull(claimInfo, nameof(claimInfo));

            var claim = mapper.Map<IdentityClaim>(claimInfo);

            IdentityResource identityResource = await identityResourceRepository.GetById(identityResourceId);

            identityResource.UserClaims.Add(claim);

            await identityResourceRepository.SaveChangesAsync();
        }

        public async Task DeleteIdentityResourceUserClaimAsync(
            int identityResourceId,
            UserClaimInfo claimInfo)
        {
            CheckId(identityResourceId);
            Check.NotNull(claimInfo, nameof(claimInfo));

            IdentityResource identityResource = await identityResourceRepository.GetById(identityResourceId);

            // We don't care if there are several claims 
            // with same Type, we delete just first 
            // of them.
            var index = identityResource.UserClaims.FindIndex(
                claim => claim.Type == claimInfo.Type);

            if (index == -1)
            {
                return;
            }

            identityResource.UserClaims.RemoveAt(index);

            await identityResourceRepository.SaveChangesAsync();
        }

        #endregion UserClaims

        private static void CheckId(int identityResourceId)
        {
            Check.BiggerOrEqual(identityResourceId, other: 0, nameof(identityResourceId));
        }
    }
}
