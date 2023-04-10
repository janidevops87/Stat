using AutoMapper;
using Statline.StatTracUploader.Domain.Main.Calls;
using Statline.StatTracUploader.Infrastructure.Services.StatTracApi.Model.Calls;

namespace Statline.StatTracUploader.Infrastructure.Persistence.StatTracApi.Calls
{
    public class CallMappingProfile : Profile
    {
        public CallMappingProfile()
        {
            CreateMap<Call, NewCall>(MemberList.Destination)
                .ForMember(dst => dst.TypeId, cfg => cfg.MapFrom(src => src.Type));
        }
    }
}
