using AutoMapper;
using Statline.StatTrac.App.LowLevel.Organizations;
using Statline.StatTrac.Domain.Organizations;
using Statline.StatTrac.Domain.Phones;
using Statline.StatTrac.Domain.SubLocations;

namespace Statline.StatTrac.Api.ViewModels.LowLevel.Organizations.Mapping;

public class OrganizationMappingProfile : Profile
{
    public OrganizationMappingProfile()
    {
        CreateMap<OrganizationFilterCriteriaViewModel, OrganizationFilterCriteria>(MemberList.Destination);
        CreateMap<OrganizationInfo, OrganizationViewModel>(MemberList.Destination);

        CreateMap<SubLocationFilterCriteriaViewModel, SubLocationFilterCriteria>(MemberList.Destination);
        CreateMap<SubLocationInfo, SubLocationViewModel>(MemberList.Destination);

        CreateMap<PhoneFilterCriteriaViewModel, PhoneFilterCriteria>(MemberList.Destination);
        CreateMap<PhoneInfo, PhoneViewModel>(MemberList.Destination);
    }
}
