using AutoMapper;
using Statline.StatTrac.Domain.Persons;

namespace Statline.StatTrac.Api.ViewModels.HighLevel.Persons.Filtered;

public class PersonMappingProfile : Profile
{
    public PersonMappingProfile()
    {
        CreateMap<PersonFilterCriteriaViewModel, PersonFilterCriteria>(MemberList.Destination);
    }
}
