using AutoMapper;
using Statline.StatTrac.App.LowLevel.Calls;

namespace Statline.StatTrac.Api.ViewModels.LowLevel.Calls.Mapping;

public class CallMappingProfile : Profile
{
    public CallMappingProfile()
    {
        CreateMap<CallInfo, CallViewModel>(MemberList.Destination);
        CreateMap<NewCallViewModel, NewCallInfo>(MemberList.Destination);
    }
}
