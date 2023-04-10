using System.Collections.Generic;
using System.Threading.Tasks;
using AutoMapper;
using IdentityServer4.EntityFramework.Entities;
using Statline.Common.Utilities;
using Statline.IdentityServer.IdentityServerConfig.App.Resources.Api.Dto;
using Statline.IdentityServer.IdentityServerConfig.App.Resources.Shared.Dto;
using Statline.IdentityServer.IdentityServerConfig.Domain.Model;

namespace Statline.IdentityServer.IdentityServerConfig.App.Resources.Api
{
    public class ApiResourceApplication
    {
        private readonly IApiResourceRepository apiResourceRepository;
        private readonly IMapper mapper;

        public ApiResourceApplication(
            IApiResourceRepository apiResourceRepository,
            IMapper mapper)
        {
            Check.NotNull(apiResourceRepository, nameof(apiResourceRepository));
            Check.NotNull(mapper, nameof(mapper));

            this.apiResourceRepository = apiResourceRepository;
            this.mapper = mapper;
        }

        #region ApiResource

        public async Task<IEnumerable<ApiResourceSummaryInfo>> ListApiResourcesAsync()
        {
            var apiResources = await apiResourceRepository.ListApiResourcesAsync();

            return mapper.Map<IEnumerable<ApiResourceSummaryInfo>>(apiResources);
        }

        public async Task<ApiResourceSummaryInfo> GetApiResourceSummaryAsync(int apiResourceId)
        {
            CheckId(apiResourceId);

            var apiResource = await apiResourceRepository.GetById(apiResourceId);

            return mapper.Map<ApiResourceSummaryInfo>(apiResource);
        }

        public async Task<int> CreateApiResourceAsync(NewApiResourceInfo newApiResourceInfo)
        {
            Check.NotNull(newApiResourceInfo, nameof(newApiResourceInfo));

            var newApiResource = mapper.Map<ApiResource>(newApiResourceInfo);

            apiResourceRepository.AddApiResource(newApiResource);

            await apiResourceRepository.SaveChangesAsync();

            return newApiResource.Id;
        }

        public async Task DeleteApiResourceAsync(int apiResourceId)
        {
            CheckId(apiResourceId);

            apiResourceRepository.DeleteApiResource(apiResourceId);

            await apiResourceRepository.SaveChangesAsync();
        }

        #endregion ApiResource

        #region Properties

        public async Task<ApiResourcePropertiesInfo> GetApiResourcePropertiesAsync(
            int apiResourceId)
        {
            CheckId(apiResourceId);

            var apiResource = await apiResourceRepository.GetById(apiResourceId);

            return mapper.Map<ApiResourcePropertiesInfo>(apiResource);
        }

        public async Task UpdateApiResourcePropertiesAsync(
            int apiResourceId,
            ApiResourcePropertiesInfo apiResourceProperties)
        {
            CheckId(apiResourceId);
            Check.NotNull(apiResourceProperties, nameof(apiResourceProperties));

            ApiResource apiResource = await apiResourceRepository.GetById(apiResourceId);

            mapper.Map(apiResourceProperties, apiResource);

            await apiResourceRepository.SaveChangesAsync();
        }

        #endregion Properties

        #region Scopes

        public async Task<ApiResourcePartInfo<IEnumerable<ScopeInfo>>>
            GetApiResourceScopesAsync(int apiResourceId)
        {
            CheckId(apiResourceId);

            var apiResource = await apiResourceRepository.GetById(apiResourceId);

            return mapper.Map<ApiResourcePartInfo<IEnumerable<ScopeInfo>>>(apiResource);
        }

        public async Task AddApiResourceScopeAsync(int apiResourceId, ScopeInfo newScope)
        {
            CheckId(apiResourceId);
            Check.NotNull(newScope, nameof(newScope));

            ApiResource apiResource = await apiResourceRepository.GetById(apiResourceId);

            if (apiResource.Scopes.Exists(s => s.Name == newScope.Name))
            {
                return;
            }

            var newApiResourceScope = mapper.Map<ApiScope>(newScope);

            apiResource.Scopes.Add(newApiResourceScope);

            await apiResourceRepository.SaveChangesAsync();
        }

        public async Task DeleteApiResourceScopeAsync(int apiResourceId, string scopeName)
        {
            CheckId(apiResourceId);
            Check.NotEmpty(scopeName, nameof(scopeName));

            ApiResource apiResource = await apiResourceRepository.GetById(apiResourceId);

            var index = apiResource.Scopes.FindIndex(
                apiResourceScope => apiResourceScope.Name == scopeName);

            if (index == -1)
            {
                return;
            }

            apiResource.Scopes.RemoveAt(index);

            await apiResourceRepository.SaveChangesAsync();
        }

        #endregion Scopes

        #region UserClaims

        public async Task<ApiResourcePartInfo<IEnumerable<UserClaimInfo>>> 
            GetApiResourceUserClaimsAsync(int apiResourceId)
        {
            CheckId(apiResourceId);

            var apiResource = await apiResourceRepository.GetById(apiResourceId);

            return mapper.Map<ApiResourcePartInfo<IEnumerable<UserClaimInfo>>>(
                apiResource);
        }

        public async Task AddApiResourceUserClaimAsync(
            int apiResourceId,
            UserClaimInfo claimInfo)
        {
            CheckId(apiResourceId);
            Check.NotNull(claimInfo, nameof(claimInfo));

            var claim = mapper.Map<ApiResourceClaim>(claimInfo);

            ApiResource apiResource = await apiResourceRepository.GetById(apiResourceId);

            apiResource.UserClaims.Add(claim);

            await apiResourceRepository.SaveChangesAsync();
        }

        public async Task DeleteApiResourceUserClaimAsync(
            int apiResourceId,
            UserClaimInfo claimInfo)
        {
            CheckId(apiResourceId);
            Check.NotNull(claimInfo, nameof(claimInfo));

            ApiResource apiResource = await apiResourceRepository.GetById(apiResourceId);

            // We don't care if there are several claims 
            // with same Type, we delete just first 
            // of them.
            var index = apiResource.UserClaims.FindIndex(
                claim => claim.Type == claimInfo.Type);

            if (index == -1)
            {
                return;
            }

            apiResource.UserClaims.RemoveAt(index);

            await apiResourceRepository.SaveChangesAsync();
        }

        #endregion UserClaims

        private static void CheckId(int apiResourceId)
        {
            Check.BiggerOrEqual(apiResourceId, other: 0, nameof(apiResourceId));
        }
    }
}
