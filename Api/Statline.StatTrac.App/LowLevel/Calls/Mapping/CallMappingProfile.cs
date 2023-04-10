using AutoMapper;
using Statline.StatTrac.Domain.Calls;

namespace Statline.StatTrac.App.LowLevel.Calls.Mapping;

public class CallMappingProfile : Profile
{
    public CallMappingProfile()
    {
        RecognizeDestinationPrefixes("Call");
        CreateMap<NewCallInfo, Call>(MemberList.Source);
    }
}
