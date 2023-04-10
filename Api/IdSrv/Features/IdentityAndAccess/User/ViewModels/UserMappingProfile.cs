using System.Collections.Generic;
using AutoMapper;
using Microsoft.AspNetCore.Mvc.Rendering;
using Statline.IdentityServer.IdentityAndAccess.App.Users.Dto;

namespace Statline.IdentityServer.Features.IdentityAndAccess.User.ViewModels
{
    public class UserMappingProfile : Profile
    {
        public UserMappingProfile()
        {
            CreateMap<
                UserListSummaryInfo,
                UserListSummaryViewModel>(MemberList.Destination)
                .ForMember(x => x.CanActivate, x => x.MapFrom(m => m.IsConfirmed));

            CreateMap<
                TenantUserSummaryInfo,
                UserSummaryViewModel>(MemberList.Destination);

            CreateMap<EditPropertiesViewModel, UserPropertiesInfo>()
                .ForCtorParam("userName", x => x.MapFrom(m => m.EditableUserName))
                .ForCtorParam("email", x => x.MapFrom(m => m.Email))
                .ReverseMap()
                .ForPath(x => x.EditableUserName, x => x.MapFrom(m => m.UserName));

            CreateMap<UserPartInfo<UserPropertiesInfo>, EditPropertiesViewModel>(MemberList.Destination)
                .ConvertUsing((src, tgt, ctx) =>
                {
                    tgt = ctx.Mapper.Map<EditPropertiesViewModel>(src.PartInfo);
                    tgt.UserName = src.UserName;
                    tgt.Id = src.Id;
                    return tgt;
                });

            CreateMap<UserPartInfo<IEnumerable<ClaimInfo>>, EditClaimsViewModel>(MemberList.Destination)
              .ForMember(m => m.Claims, o => o.MapFrom(m => m.PartInfo));

            CreateMap<UserPartInfo<IEnumerable<RoleInfo>>, EditRolesViewModel>(MemberList.Destination)
              .ForMember(m => m.Roles, o => o.MapFrom(m => m.PartInfo));

            CreateMap<ClaimViewModel, ClaimInfo>(MemberList.Destination).ReverseMap();

            CreateMap<RoleViewModel, RoleInfo>(MemberList.Destination).ReverseMap();

            CreateMap<SelectRoleViewModel, RoleInfo>(MemberList.Destination)
                .ForCtorParam("name", x => x.MapFrom(m => m.SelectedRoleName));

            CreateMap<
                RoleInfo,
                SelectListItem>(MemberList.Source)
              .ForMember(x => x.Text, x => x.MapFrom(m => m.Name))
              .ForMember(x => x.Value, x => x.MapFrom(m => m.Name));
        }
    }
}
