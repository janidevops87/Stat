using AutoMapper;
using Statline.StatTrac.App.LowLevel.Persons;
using Statline.StatTrac.Domain.Common;
using Statline.StatTrac.Domain.Persons;

namespace Statline.StatTrac.Api.ViewModels.LowLevel.Persons.Mapping;

public class PersonMappingProfile : Profile
{
    public PersonMappingProfile()
    {
        CreateMap<EmployeeFilterCriteriaViewModel, EmployeeFilterCriteria>(MemberList.Destination)
            .ForCtorParam(nameof(EmployeeFilterCriteria.ActiveState), opt => opt.MapFrom(
                (critVm, crit) => critVm.Inactive switch
                {
                    true => ActiveStateFilter.InactiveOnly,
                    false => ActiveStateFilter.ActiveOnly,
                    null => ActiveStateFilter.ActiveAndInactive
                }));

        CreateMap<StatEmployeeInfo, StatEmployeeViewModel>(MemberList.Destination);

        CreateMap<PersonFilterCriteriaViewModel, PersonFilterCriteria>(MemberList.Destination)
            .ForCtorParam(nameof(PersonFilterCriteria.ActiveState), opt => opt.MapFrom(
                (critVm, crit) => critVm.Inactive switch
                {
                    true => ActiveStateFilter.InactiveOnly,
                    false => ActiveStateFilter.ActiveOnly,
                    null => ActiveStateFilter.ActiveAndInactive
                }));
        CreateMap<PersonInfo, PersonViewModel>(MemberList.Destination);
    }
}
