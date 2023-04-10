using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Statline.StatTrac.Api.Common.Security;
using Statline.StatTrac.Api.ViewModels.LowLevel.LogEvents;
using Statline.StatTrac.App.LowLevel.LogEvents;

namespace Statline.StatTrac.Api.Controllers.LowLevel;

[ApiVersion("1.0")]
[Route("api/v{version:apiVersion}/[controller]")]
[Authorize(AuthorizationPolicies.StatTracLowLevelApiPolicy)]
[ApiController]
public class LogEventsController : ControllerBase
{
    private readonly LogEventsApplication logEventsApplication;
    private readonly IMapper mapper;

    public LogEventsController(
        LogEventsApplication logEventsApplication,
        IMapper mapper)
    {
        this.logEventsApplication = Check.NotNull(logEventsApplication, nameof(logEventsApplication));
        this.mapper = Check.NotNull(mapper, nameof(mapper));
    }

    [HttpGet("{logEventId:int:min(1)}", Name = nameof(FindLogEventById))]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public async Task<ActionResult<LogEventViewModel>> FindLogEventById(int logEventId)
    {
        var logEvent = await logEventsApplication.FindLogEventByIdAsync(logEventId);

        if (logEvent is null)
        {
            return NotFound();
        }

        return Ok(mapper.Map<LogEventViewModel>(logEvent));
    }

    [HttpPost(Name = nameof(AddLogEvent))]
    [ProducesResponseType(StatusCodes.Status201Created)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public async Task<ActionResult<int>> AddLogEvent(NewLogEventViewModel newLogEvent)
    {
        var newLogEventInfo = mapper.Map<NewLogEventInfo>(newLogEvent);

        int logEventId = await logEventsApplication.AddLogEventAsync(newLogEventInfo);

        return CreatedAtAction(nameof(FindLogEventById), new { logEventId }, value: logEventId);
    }
}
