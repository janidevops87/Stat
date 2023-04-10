using System.Collections.Generic;
using AutoMapper;
using Statline.IdentityServer.IdentityServerConfig.App.Resources.Shared.Dto;
using Entities = IdentityServer4.EntityFramework.Entities;

namespace Statline.IdentityServer.IdentityServerConfig.App.Resources.Api.Dto
{
    public class ApiResourceMappingProfile : Profile
    {
        public ApiResourceMappingProfile()
        {
            CreateMap<
                Entities.ApiResource,
                ApiResourceSummaryInfo>(MemberList.Destination);

            CreateMap<NewApiResourceInfo, Entities.ApiResource>(MemberList.Source);

            CreateMap<Entities.ApiResource, ApiResourcePartInfo<IEnumerable<ScopeInfo>>>(MemberList.Destination)
                .ForMember(x => x.ApiResourceId, x => x.MapFrom(m => m.Id))
                .ForMember(x => x.ApiResourceName, x => x.MapFrom(m => m.Name))
                .ForMember(x => x.PartInfo, x => x.MapFrom(m => m.Scopes));

            CreateMap<Entities.ApiResource, ApiResourcePartInfo<IEnumerable<UserClaimInfo>>>(MemberList.Destination)
                .ForMember(x => x.ApiResourceId, x => x.MapFrom(m => m.Id))
                .ForMember(x => x.ApiResourceName, x => x.MapFrom(m => m.Name))
                .ForMember(x => x.PartInfo, x => x.MapFrom(m => m.UserClaims));

            CreateMap<Entities.ApiResource, ApiResourcePropertiesInfo>(MemberList.Destination)
                .ReverseMap();

            CreateMap<Entities.ApiResourceClaim, UserClaimInfo>(MemberList.Destination).ReverseMap();

            CreateMap<Entities.ApiScope, ScopeInfo>(MemberList.Destination).ReverseMap();
        }
    }
}
