using AutoMapper;
using Statline.StatTrac.Domain.Phones;

namespace Statline.StatTrac.Api.ViewModels.HighLevel.Phones.Filtered;

public class MappingProfile : Profile
{
    public MappingProfile()
    {
        CreateMap<PhoneFilterCriteriaViewModel, PhoneFilterCriteria>(MemberList.Destination);
    }
}
