using System.Collections.Generic;
using AutoMapper;
using Statline.IdentityServer.IdentityServerConfig.App.Resources.Api.Dto;
using Statline.IdentityServer.IdentityServerConfig.App.Resources.Shared.Dto;

namespace Statline.IdentityServer.Features.IdentityServerConfig.Api.ViewModels
{
    public class ApiResourceMappingProfile : Profile
    {
        public ApiResourceMappingProfile()
        {
            CreateMap<
                ApiResourceSummaryInfo,
                ApiResourceSummaryViewModel>(MemberList.Destination);

            CreateMap<NewApiResourceViewModel, NewApiResourceInfo>(MemberList.Destination);

            CreateMap<EditPropertiesViewModel, ApiResourcePropertiesInfo>(MemberList.Destination)
                .ReverseMap()
                .ForPath(x => x.ApiResourceName, x => x.MapFrom(m => m.Name));

            CreateMap<UserClaimViewModel, UserClaimInfo>(MemberList.Destination).ReverseMap();

            CreateMap<ScopeViewModel, ScopeInfo>(MemberList.Destination)
                .ReverseMap();


            CreateMap<IEnumerable<UserClaimInfo>, EditUserClaimsViewModel>(MemberList.Source)
                .ForMember(m => m.UserClaims, cfg => cfg.MapFrom((src, dst) => src))
                .ReverseMap();

            CreateMap<ApiResourcePartInfo<IEnumerable<ScopeInfo>>, EditScopesViewModel>(MemberList.Destination)
                .ForMember(m => m.Scopes, o => o.MapFrom(m => m.PartInfo));

            CreateMap<ApiResourcePartInfo<IEnumerable<UserClaimInfo>>, EditUserClaimsViewModel>(MemberList.Destination)
                .ForMember(m => m.UserClaims, o => o.MapFrom(m => m.PartInfo));
        }
    }
}
