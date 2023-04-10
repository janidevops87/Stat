using AutoMapper;
using Statline.StatTrac.Api.ViewModels.EReferral;
using Statline.StatTrac.App.Enums;

namespace Statline.StatTrac.Api.ViewModels.EReferral.Mapping;

public class EReferralMappingProfile : Profile
{
    public EReferralMappingProfile()
    {
        CreateMap<EnumValueInfo, EReferralRaceViewModel>(MemberList.Destination)
            .ForMember(dst => dst.RaceId, cfg => cfg.MapFrom(src => src.Id))
            .ForMember(dst => dst.RaceName, cfg => cfg.MapFrom(src => src.Name));
    }
}
