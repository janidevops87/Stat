using AutoMapper;
using Statline.IdentityServer.IdentityServerConfig.App.Resources.Identity.Dto;
using Statline.IdentityServer.IdentityServerConfig.App.Resources.Shared.Dto;
using System.Collections.Generic;

namespace Statline.IdentityServer.Features.IdentityServerConfig.Identity.ViewModels
{
    public class IdentityResourceMappingProfile : Profile
    {
        public IdentityResourceMappingProfile()
        {
            CreateMap<
                IdentityResourceSummaryInfo,
                IdentityResourceSummaryViewModel>(MemberList.Destination);

            CreateMap<NewIdentityResourceViewModel, NewIdentityResourceInfo>(MemberList.Destination);

            CreateMap<EditPropertiesViewModel, IdentityResourcePropertiesInfo>(MemberList.Destination)
                .ReverseMap()
                .ForPath(x => x.IdentityResourceName, x => x.MapFrom(m => m.Name));

            CreateMap<UserClaimViewModel, UserClaimInfo>(MemberList.Destination).ReverseMap();

            CreateMap<IEnumerable<UserClaimInfo>, EditUserClaimsViewModel>(MemberList.Source)
                .ForMember(m => m.UserClaims, cfg => cfg.MapFrom((src, dst) => src))
                .ReverseMap();

            CreateMap<IdentityResourcePartInfo<IEnumerable<UserClaimInfo>>, EditUserClaimsViewModel>(MemberList.Destination)
                .ForMember(m => m.UserClaims, o => o.MapFrom(m => m.PartInfo));
        }
    }
}
