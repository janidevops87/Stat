using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Statline.Common.Repository;
using Statline.StatTrac.Api.Common.Security;
using Statline.StatTrac.Api.ViewModels.HighLevel.LogEvents.NewLogEvent;
using Statline.StatTrac.App.HighLevel.LogEvents;
using Statline.StatTrac.Domain.Common;
using Statline.StatTrac.Domain.LogEvents.Factory;

namespace Statline.StatTrac.Api.Controllers.HighLevel;

[ApiVersion("2.0")]
[Route("api/v{version:apiVersion}/referrals/{referralId:int:min(1)}/logevents/")]
[ApiController]
public class RefrralLogEventsHighLevelController : ControllerBase
{
    private readonly LogEventsHighLevelApplication logEventsApplication;
    private readonly IMapper mapper;

    public RefrralLogEventsHighLevelController(
        LogEventsHighLevelApplication logEventsApplication,
        IMapper mapper)
    {
        this.logEventsApplication = Check.NotNull(logEventsApplication);
        this.mapper = Check.NotNull(mapper);
    }

    [Authorize(AuthorizationPolicies.StatTracApiLogEventCreate)]
    [HttpPost(Name = nameof(AddReferralLogEvent))]
    [ProducesResponseType(StatusCodes.Status201Created)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public async Task<ActionResult<int>> AddReferralLogEvent(
        int referralId,
        ReferralLogEventViewModel newLogEvent)
    {
        int? statEmployeeId = await User.GetAssociatedStatEmployeeIdAsync();

        if (statEmployeeId is null)
        {
            return Unauthorized("Can't find employee associated with provided credentials.");
        }

        var newLogEventInfo = mapper.Map<ReferralLogEventInfo>(newLogEvent);

        int logEventId = await logEventsApplication.AddReferralLogEventAsync(
                referralId,
                newLogEventInfo,
                statEmployeeId.Value);

        return CreatedAtAction(
            nameof(FindReferralLogEventById),
            new { logEventId, referralId },
            value: logEventId);
    }

    // Hide this api from swagger docs until it's implemented
    [ApiExplorerSettings(IgnoreApi = true)]
    [Authorize(AuthorizationPolicies.StatTracApiLogEventRead)]
    [HttpGet("{logEventId:int:min(1)}", Name = nameof(FindReferralLogEventById))]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public ActionResult FindReferralLogEventById(int referralId, int logEventId)
    {
        return BadRequest("Not implemented yet");
    }
}
