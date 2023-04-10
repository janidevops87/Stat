using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Statline.StatTrac.Api.Common.Security;
using Statline.StatTrac.Api.ViewModels.Heartbeat;
using Statline.StatTrac.App.Heartbeat;

namespace Statline.StatTrac.Api.Controllers;

[ApiVersion("1.0")]
[Route("api/v{version:apiVersion}/[controller]")]
[Authorize(AuthorizationPolicies.StatTracLowLevelApiPolicy)]
[ApiController]
public class HeartbeatController : ControllerBase
{
    private readonly HeartbeatApplication heartbeatApplication;
    private readonly IMapper mapper;

    public HeartbeatController(
        HeartbeatApplication heartbeatApplication,
        IMapper mapper)
    {
        Check.NotNull(heartbeatApplication, nameof(heartbeatApplication));
        Check.NotNull(mapper, nameof(mapper));
        this.heartbeatApplication = heartbeatApplication;
        this.mapper = mapper;
    }

    /// <summary>
    /// Verifies communication between a user's computer and the server.
    /// Also checks health of downstream systems and services. 
    /// </summary>
    [HttpGet]
    public async Task<ActionResult<ApplicationHealthReportViewModel>> Get()
    {
        var appHealthReport = await heartbeatApplication.CheckAppHealthAsync();

        return mapper.Map<ApplicationHealthReportViewModel>(appHealthReport);
    }
}