using System.Collections.Generic;
using AutoMapper;
using Microsoft.AspNetCore.Mvc.Rendering;
using Statline.IdentityServer.IdentityAndAccess.App.Tenants.Dto;

namespace Statline.IdentityServer.Features.IdentityAndAccess.Tenant.ViewModels
{
    public class TenantMappingProfile : Profile
    {
        public TenantMappingProfile()
        {
            CreateMap<
                TenantListSummaryInfo,
                TenantListSummaryViewModel>(MemberList.Destination);

            CreateMap<
                TenantSummaryInfo,
                TenantSummaryViewModel>(MemberList.Destination);

            CreateMap<
                TenantListSummaryInfo,
                SelectListItem>(MemberList.Source)
              .ForMember(x => x.Text, x => x.MapFrom(m => m.OrganizationName))
              .ForMember(x => x.Value, x => x.MapFrom(m => m.Id));

            CreateMap<
                NewTenantViewModel,
                NewTenantInfo>(MemberList.Destination);

            CreateMap<EditPropertiesViewModel, TenantPropertiesInfo>()
                .ForCtorParam("organizationName", x => x.MapFrom(m => m.EditableOrganizationName))
                .ReverseMap()
                .ForPath(x => x.EditableOrganizationName, x => x.MapFrom(m => m.OrganizationName));

            CreateMap<TenantPartInfo<TenantPropertiesInfo>, EditPropertiesViewModel>(MemberList.Destination)
                .ConvertUsing((src, tgt, ctx) =>
                {
                    tgt = ctx.Mapper.Map<EditPropertiesViewModel>(src.PartInfo);
                    tgt.OrganizationName = src.OrganizationName;
                    tgt.Id = src.Id;
                    return tgt;
                });

            CreateMap<TenantPartInfo<IEnumerable<ClaimInfo>>, EditClaimsViewModel>(MemberList.Destination)
              .ForMember(m => m.Claims, o => o.MapFrom(m => m.PartInfo));

            CreateMap<ClaimViewModel, ClaimInfo>(MemberList.Destination).ReverseMap();

            CreateMap<ClaimInfo, System.Security.Claims.Claim>(MemberList.Source).ReverseMap();
        }
    }
}
