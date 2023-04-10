using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Statline.StatTrac.Api.Common.Security;
using Statline.StatTrac.Api.ViewModels.QAProcessor;
using Statline.StatTrac.App.QAProcessor;
using System.Linq;

namespace Statline.StatTrac.Api.Controllers;

[ApiVersion("1.0")]
[Route("api/v{version:apiVersion}/[controller]")]
// Using general policy as this api is not intended to
// be accessed from outside of the company.
[Authorize(AuthorizationPolicies.StatTracLowLevelApiPolicy)]
[ApiController]
[ApiExplorerSettings(IgnoreApi = true)]
public class QAProcessorController : ControllerBase
{
    private readonly QAProcessorApplication qaProcessorApplication;

    public QAProcessorController(
        QAProcessorApplication qaProcessorApplication)
    {
        Check.NotNull(qaProcessorApplication, nameof(qaProcessorApplication));
        this.qaProcessorApplication = qaProcessorApplication;
    }

    [HttpGet("calls/{callId:int:min(1)}/timings", Name = nameof(GetCallTimings))]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public async Task<ActionResult<CallTimingsViewModel>> GetCallTimings(int callId)
    {
        var callTimings = await qaProcessorApplication.GetCallTimingsAsync(callId);

        if (callTimings is null)
        {
            return NotFound();
        }

        return Ok(new CallTimingsViewModel(callTimings.CallStart, callTimings.CallEnd));
    }

    [HttpGet("referrals/with-high-risk-calls", Name = nameof(GetHighRiskCallReferrals))]
    public async Task<IEnumerable<HighRiskCallReferralViewModel>> GetHighRiskCallReferrals(
        DateTimeOffset from,
        DateTimeOffset to)
    {
        var referrals = await qaProcessorApplication.GetHighRiskCallReferralsAsync(from, to);

        return referrals.Select(r => new HighRiskCallReferralViewModel(r.ReferralId, r.LogEventId, r.RiskType));
    }
}
