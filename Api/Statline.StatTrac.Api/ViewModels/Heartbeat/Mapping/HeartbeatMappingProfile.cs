using AutoMapper;
using Statline.StatTrac.App.Heartbeat;

namespace Statline.StatTrac.Api.ViewModels.Heartbeat.Mapping;

public class HeartbeatMappingProfile : Profile
{
    public HeartbeatMappingProfile()
    {
        CreateMap<ApplicationHealthReport, ApplicationHealthReportViewModel>(MemberList.Destination);
        CreateMap<SqlServerHealthReport, SqlServerHealthReportViewModel>(MemberList.Destination);
    }
}
