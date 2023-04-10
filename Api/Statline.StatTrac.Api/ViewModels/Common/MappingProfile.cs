using AutoMapper;
using Statline.StatTrac.Domain.Common;

namespace Statline.StatTrac.Api.ViewModels.Common;

public class MappingProfile : Profile
{
    public MappingProfile()
    {
        CreateMap<PersonNameViewModel, PersonName>(MemberList.Source);
        CreateMap<PersonAgeViewModel, PersonAge>(MemberList.Source);
        CreateMap<PersonWeightViewModel, PersonWeight>(MemberList.Source);
        CreateMap<PhoneNumberViewModel, PhoneNumber>(MemberList.Destination).ReverseMap();
    }
}
