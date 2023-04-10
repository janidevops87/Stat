using AutoMapper;
using Statline.StatTrac.App.Enums;

namespace Statline.StatTrac.Api.ViewModels.Enums.Mapping;

public class EnumsMappingProfile : Profile
{
    public EnumsMappingProfile()
    {
        CreateMap<EnumValueInfo, EnumValueViewModel>(MemberList.Destination);
    }
}
