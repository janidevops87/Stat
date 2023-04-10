using System.Collections.Generic;
using AutoMapper;
using Statline.IdentityServer.IdentityAndAccess.App.Roles.Dto;

namespace Statline.IdentityServer.Features.IdentityAndAccess.Role.ViewModels
{
    public class RoleMappingProfile : Profile
    {
        public RoleMappingProfile()
        {
            CreateMap<
                RoleListSummaryInfo,
                RoleListSummaryViewModel>(MemberList.Destination);

            CreateMap<EditPropertiesViewModel, RolePropertiesInfo>()
                .ForCtorParam("name", x => x.MapFrom(m => m.EditableName))
                .ReverseMap()
                .ForPath(x => x.EditableName, x => x.MapFrom(m => m.Name));

            CreateMap<RolePartInfo<RolePropertiesInfo>, EditPropertiesViewModel>(MemberList.Destination)
                .ConvertUsing((src, tgt, ctx) =>
                {
                    tgt = ctx.Mapper.Map<EditPropertiesViewModel>(src.PartInfo);
                    tgt.Name = src.Name;
                    tgt.Id = src.Id;
                    return tgt;
                });

            CreateMap<
                NewRoleViewModel,
                NewRoleInfo>(MemberList.Destination);
        }
    }
}
