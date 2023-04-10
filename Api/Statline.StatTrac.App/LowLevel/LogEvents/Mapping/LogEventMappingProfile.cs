using AutoMapper;
using Statline.StatTrac.Domain.LogEvents;

namespace Statline.StatTrac.App.LowLevel.LogEvents.Mapping;

public class LogEventMappingProfile : Profile
{
    public LogEventMappingProfile()
    {
        RecognizeDestinationPrefixes("LogEvent");
        CreateMap<NewLogEventInfo, LogEvent>(MemberList.Source)
            .ForMember(dst => dst.LogEventOrg, cfg => cfg.MapFrom(src => src.OrganizationName))
            .ForMember(dst => dst.PersonId, cfg => cfg.MapFrom(src => src.FromToPersonId))
            .ForMember(dst => dst.LogEventDesc, cfg => cfg.MapFrom(src => src.Description))
            .ForMember(dst => dst.LogEventName, cfg => cfg.MapFrom(src => src.FromToPersonName));

    }
}
