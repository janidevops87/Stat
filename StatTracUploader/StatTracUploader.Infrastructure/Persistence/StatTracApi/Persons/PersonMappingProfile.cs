using AutoMapper;
using Statline.StatTracUploader.Domain.Common;

namespace Statline.StatTracUploader.Infrastructure.Persistence.StatTracApi.Persons
{
    public class PersonMappingProfile : Profile
    {
        public PersonMappingProfile()
        {
            CreateMap<
                Domain.Main.Persons.PersonFilterCriteria,
                Services.StatTracApi.Model.Persons.PersonFilterCriteria>(MemberList.Destination)
                    .ForMember(dst => dst.FirstName, cfg => cfg.MapFrom(src => src.Name!.FirstName))
                    .ForMember(dst => dst.LastName, cfg => cfg.MapFrom(src => src.Name!.LastName));

            CreateMap<
                Services.StatTracApi.Model.Persons.StatEmployee,
                Domain.Main.Persons.StatEmployee>(MemberList.Destination)
                    .ForCtorParam("name", cfg => cfg.MapFrom(
                        (src, dst) => new PersonName(src.FirstName, src.LastName)));
        }
    }
}
