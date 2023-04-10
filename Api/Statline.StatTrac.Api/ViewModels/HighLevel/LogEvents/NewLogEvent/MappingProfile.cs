using AutoMapper;
using Statline.StatTrac.Domain.LogEvents.Factory;
using Statline.StatTrac.Domain.Organizations;

namespace Statline.StatTrac.Api.ViewModels.HighLevel.LogEvents.NewLogEvent;

public class MappingProfile : Profile
{
    public MappingProfile()
    {
        CreateMap<LogEventViewModel, LogEventInfo>(MemberList.Source);
        CreateMap<ReferralLogEventViewModel, ReferralLogEventInfo>(MemberList.Source);
        CreateMap<int, OrganizationId>().ConvertUsing(v => new(v));
    }
}
