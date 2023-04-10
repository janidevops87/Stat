using System.Collections.Generic;
using AutoMapper;
using Statline.IdentityServer.IdentityServerConfig.App.Resources.Shared.Dto;
using Entities = IdentityServer4.EntityFramework.Entities;

namespace Statline.IdentityServer.IdentityServerConfig.App.Resources.Identity.Dto
{
    public class IdentityResourceMappingProfile : Profile
    {
        public IdentityResourceMappingProfile()
        {
            CreateMap<
                Entities.IdentityResource,
                IdentityResourceSummaryInfo>(MemberList.Destination);

            CreateMap<NewIdentityResourceInfo, Entities.IdentityResource>(MemberList.Source);

            CreateMap<Entities.IdentityResource, IdentityResourcePartInfo<IEnumerable<UserClaimInfo>>>(MemberList.Destination)
                .ForMember(x => x.IdentityResourceId, x => x.MapFrom(m => m.Id))
                .ForMember(x => x.IdentityResourceName, x => x.MapFrom(m => m.Name))
                .ForMember(x => x.PartInfo, x => x.MapFrom(m => m.UserClaims));

            CreateMap<Entities.IdentityResource, IdentityResourcePropertiesInfo>(MemberList.Destination)
                .ReverseMap();

            CreateMap<Entities.IdentityClaim, UserClaimInfo>(MemberList.Destination).ReverseMap();
        }
    }
}
