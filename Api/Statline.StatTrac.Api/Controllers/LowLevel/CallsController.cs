using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Statline.StatTrac.Api.Common.Security;
using Statline.StatTrac.Api.ViewModels.LowLevel.Calls;
using Statline.StatTrac.App.LowLevel.Calls;

namespace Statline.StatTrac.Api.Controllers.LowLevel;

[ApiVersion("1.0")]
[Route("api/v{version:apiVersion}/[controller]")]
[Authorize(AuthorizationPolicies.StatTracLowLevelApiPolicy)]
[ApiController]
public class CallsController : ControllerBase
{
    private readonly CallsApplication callsApplication;
    private readonly IMapper mapper;

    public CallsController(
        CallsApplication callsApplication,
        IMapper mapper)
    {
        this.callsApplication = Check.NotNull(callsApplication, nameof(callsApplication));
        this.mapper = Check.NotNull(mapper, nameof(mapper));
    }

    [HttpGet("{callId:int:min(1)}", Name = nameof(FindCallById))]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public async Task<ActionResult<CallViewModel>> FindCallById(int callId)
    {
        var call = await callsApplication.FindCallByIdAsync(callId);

        if (call is null)
        {
            return NotFound();
        }

        return Ok(mapper.Map<CallViewModel>(call));
    }

    [HttpPost(Name = nameof(AddCall))]
    [ProducesResponseType(StatusCodes.Status201Created)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public async Task<ActionResult<int>> AddCall(NewCallViewModel newCall)
    {
        var newCallInfo = mapper.Map<NewCallInfo>(newCall);

        int callId = await callsApplication.AddCallAsync(newCallInfo);

        return CreatedAtAction(nameof(FindCallById), new { callId }, value: callId);
    }
}
