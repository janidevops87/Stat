using AutoMapper;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Command;

namespace Statline.IdentityServer.IdentityAndAccess.App.Roles.Dto
{
    public class RoleMappingProfile : Profile
    {
        public RoleMappingProfile()
        {
            CreateMap<Role, RoleListSummaryInfo>(MemberList.Destination);

            CreateMap<Role, RolePropertiesInfo>(MemberList.Destination).ReverseMap();

            CreateMap<Role, RolePartInfo<RolePropertiesInfo>>(MemberList.Destination)
                .ForMember(x => x.PartInfo, cfg => cfg.MapFrom((src, dst) => src));

            CreateMap<NewRoleInfo, Role>(MemberList.Source);
        }
    }
}
