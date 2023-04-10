using AutoMapper;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Command;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Query;
using System.Collections.Generic;

namespace Statline.IdentityServer.IdentityAndAccess.App.Users.Dto
{
    public class UserMappingProfile : Profile
    {
        public UserMappingProfile()
        {
            CreateMap<User, TenantUserSummaryInfo>(MemberList.None);
            CreateMap<TenantUserInfo, TenantUserSummaryInfo>(MemberList.None);

            CreateMap<TenantUserInfo, UserListSummaryInfo>(MemberList.Destination);

            CreateMap<UserInfo, UserSummaryInfo>(MemberList.Destination);

            CreateMap<User, UserPropertiesInfo>(MemberList.Destination).ReverseMap();

            CreateMap<User, UserPartInfo<UserPropertiesInfo>>(MemberList.Destination)
                .ForMember(x => x.PartInfo, cfg => cfg.MapFrom((src, dst) => src));

            CreateMap<IEnumerable<System.Security.Claims.Claim>, UserPartInfo<IEnumerable<ClaimInfo>>>(MemberList.Destination)
                .ForMember(x => x.PartInfo, cfg => cfg.MapFrom((src, dst) => src));

            CreateMap<IEnumerable<string>, UserPartInfo<IEnumerable<RoleInfo>>>(MemberList.Destination)
               .ForMember(x => x.PartInfo, cfg => cfg.MapFrom((src, dst) => src));

            CreateMap<User, UserPartInfo<IEnumerable<ClaimInfo>>>(MemberList.None);

            CreateMap<User, UserPartInfo<IEnumerable<RoleInfo>>>(MemberList.None);

            CreateMap<NewUserInfo, User>(MemberList.Source);

            CreateMap<System.Security.Claims.Claim, ClaimInfo>(MemberList.Destination)
                .ReverseMap();

            CreateMap<string, RoleInfo>(MemberList.Destination)
                .ForCtorParam("name", cfg => cfg.MapFrom((src, dst) => src))
                .ReverseMap();

            CreateMap<Role, RoleInfo>(MemberList.Destination);
        }
    }
}
