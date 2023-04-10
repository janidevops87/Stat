using AutoMapper;
using Statline.StatTrac.App.LowLevel.LogEvents;

namespace Statline.StatTrac.Api.ViewModels.LowLevel.LogEvents.Mapping;

public class LogEventMappingProfile : Profile
{
    public LogEventMappingProfile()
    {
        CreateMap<LogEventInfo, LogEventViewModel>(MemberList.Destination);
        CreateMap<NewLogEventViewModel, NewLogEventInfo>(MemberList.Destination);
    }
}
