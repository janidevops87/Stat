using AutoMapper;
using Statline.StatTrac.Api.ViewModels.HighLevel.Common;
using Statline.StatTrac.Domain.Phones.Factory;

namespace Statline.StatTrac.Api.ViewModels.HighLevel.Phones.NewPhone;

public class MappingProfile : Profile
{
    public MappingProfile()
    {
        CreateMap<HospitalSubLocationViewModel, HospitalSubLocationInfo>(MemberList.Source);
        CreateMap<PhoneViewModel, PhoneInfo>(MemberList.Source);
    }
}
