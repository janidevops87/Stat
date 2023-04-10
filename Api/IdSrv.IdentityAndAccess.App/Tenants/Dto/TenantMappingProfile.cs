using System.Collections.Generic;
using AutoMapper;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Command;

namespace Statline.IdentityServer.IdentityAndAccess.App.Tenants.Dto
{
    public class TenantMappingProfile : Profile
    {
        public TenantMappingProfile()
        {
            CreateMap<Tenant, TenantListSummaryInfo>(MemberList.Destination);

            CreateMap<
                Tenant,
                TenantSummaryInfo>(MemberList.Destination);


            CreateMap<Tenant, TenantPropertiesInfo>(MemberList.Destination).ReverseMap();

            CreateMap<Tenant, TenantPartInfo<TenantPropertiesInfo>>(MemberList.Destination)
                .ForMember(x => x.PartInfo, cfg => cfg.MapFrom((src, dst) => src));

            CreateMap<IEnumerable<Claim>, TenantPartInfo<IEnumerable<ClaimInfo>>>(MemberList.Destination)
                .ForMember(x => x.PartInfo, cfg => cfg.MapFrom((src, dst) => src));

            CreateMap<Tenant, TenantPartInfo<IEnumerable<ClaimInfo>>>(MemberList.None);

            CreateMap<NewTenantInfo, Tenant>(MemberList.Source);

            CreateMap<Claim, ClaimInfo>(MemberList.Destination)
                .ReverseMap();
        }
    }
}
