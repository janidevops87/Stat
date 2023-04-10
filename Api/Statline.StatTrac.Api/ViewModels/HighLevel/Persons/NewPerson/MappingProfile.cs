using AutoMapper;
using Statline.StatTrac.Domain.Persons.Factory;

namespace Statline.StatTrac.Api.ViewModels.HighLevel.Persons.NewPerson;

public class MappingProfile : Profile
{
    public MappingProfile()
    {
        CreateMap<PersonViewModel, PersonInfo>(MemberList.Source);
    }
}
