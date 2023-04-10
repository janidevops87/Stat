using AutoMapper;

namespace Statline.StatTracUploader.Infrastructure.Persistence.StatTracApi.Organizations
{
    public class OrganizationMappingProfile : Profile
    {
        public OrganizationMappingProfile()
        {
            CreateMap<
                Services.StatTracApi.Model.Organizations.Organization,
                Domain.Main.Organizations.Organization>(MemberList.Destination);

            CreateMap<
                Domain.Main.Organizations.OrganizationFilterCriteria,
                Services.StatTracApi.Model.Organizations.OrganizationFilterCriteria>(MemberList.Destination);

            CreateMap<
                Services.StatTracApi.Model.Organizations.SubLocation,
                Domain.Main.Organizations.SubLocation>(MemberList.Destination);
            CreateMap<
                Domain.Main.Organizations.SubLocationFilterCriteria,
                Services.StatTracApi.Model.Organizations.SubLocationFilterCriteria>(MemberList.Destination);

            CreateMap<
                Domain.Main.Organizations.PhoneFilterCriteria,
                Services.StatTracApi.Model.Organizations.PhoneFilterCriteria>(MemberList.Destination);
        }
    }
}
