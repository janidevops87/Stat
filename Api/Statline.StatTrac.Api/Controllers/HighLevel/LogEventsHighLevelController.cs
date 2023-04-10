using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Statline.StatTrac.Api.Common.Security;
using Statline.StatTrac.Api.ViewModels.HighLevel.LogEvents.NewLogEvent;
using Statline.StatTrac.App.HighLevel.LogEvents;
using Statline.StatTrac.Domain.Common;
using Statline.StatTrac.Domain.LogEvents.Factory;

namespace Statline.StatTrac.Api.Controllers.HighLevel;

[ApiVersion("2.0")]
[Route("api/v{version:apiVersion}/logevents")]
[ApiController]
public class LogEventsHighLevelController : ControllerBase
{
    private readonly LogEventsHighLevelApplication logEventsApplication;
    private readonly IMapper mapper;

    public LogEventsHighLevelController(
        LogEventsHighLevelApplication logEventsApplication,
        IMapper mapper)
    {
        this.logEventsApplication = Check.NotNull(logEventsApplication);
        this.mapper = Check.NotNull(mapper);
    }

    // Hide this api from swagger docs until it's implemented
    [ApiExplorerSettings(IgnoreApi = true)]
    [Authorize(AuthorizationPolicies.StatTracApiLogEventRead)]
    [HttpGet("{logEventId:int:min(1)}", Name = nameof(FindLogEventById))]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public ActionResult FindLogEventById(int logEventId)
    {
        return BadRequest("Not implemented yet");
    }

    [Authorize(AuthorizationPolicies.StatTracApiLogEventCreate)]
    [HttpPost(Name = nameof(AddLogEvent))]
    [ProducesResponseType(StatusCodes.Status201Created)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public async Task<ActionResult<int>> AddLogEvent(
        LogEventViewModel newLogEvent)
    {
        int? statEmployeeId = await User.GetAssociatedStatEmployeeIdAsync();

        if (statEmployeeId is null)
        {
            return Unauthorized("Can't find employee associated with provided credentials.");
        }

        var newLogEventInfo = mapper.Map<LogEventInfo>(newLogEvent);

        int logEventId = await logEventsApplication.AddLogEventAsync(
            newLogEventInfo,
            statEmployeeId.Value);

        return CreatedAtAction(
            nameof(FindLogEventById),
            new { logEventId },
            value: logEventId);
    }
}
