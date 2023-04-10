using AutoMapper;
using Statline.StatTracUploader.Domain.Main.LogEvents;
using Statline.StatTracUploader.Infrastructure.Services.StatTracApi.Model.LogEvents;

namespace Statline.StatTracUploader.Infrastructure.Persistence.StatTracApi.LogEvents
{
    public class LogEventMappingProfile : Profile
    {
        public LogEventMappingProfile()
        {
            CreateMap<LogEvent, NewLogEvent>(MemberList.Destination)
                .ForMember(dst => dst.TypeId, cfg => cfg.MapFrom(src => src.Type));
        }
    }
}
