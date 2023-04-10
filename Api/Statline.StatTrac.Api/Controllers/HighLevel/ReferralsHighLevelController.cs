using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Statline.StatTrac.Api.Common.Security;
using Statline.StatTrac.Api.ViewModels.HighLevel.Referrals.NewReferral;
using Statline.StatTrac.App.HighLevel.LogEvents;
using Statline.StatTrac.App.HighLevel.Referrals;
using Statline.StatTrac.App.HighLevel.Referrals.Dto.NewReferral;
using Statline.StatTrac.Domain.Common;

namespace Statline.StatTrac.Api.Controllers.HighLevel;

[ApiVersion("2.0")]
[Route("api/v{version:apiVersion}/referrals")]
[ApiController]
public class ReferralsHighLevelController : ControllerBase
{
    private readonly ReferralsHighLevelApplication referralsApplication;

    public ReferralsHighLevelController(ReferralsHighLevelApplication referralsApplication)
    {
        this.referralsApplication = Check.NotNull(referralsApplication);
    }

    [Authorize(AuthorizationPolicies.StatTracApiReferralCreate)]
    [HttpPost(Name = nameof(AddReferral))]
    [ProducesResponseType(StatusCodes.Status201Created)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public async Task<ActionResult<CreatedReferralViewModel>> AddReferral(
       ReferralViewModel newReferral,
       [FromServices] LogEventsHighLevelApplication logEventsApplication,
       [FromServices] IMapper mapper)
    {
        // TODO: This code should probably be somehow "automated",
        // as with api growing we'll need to repeat it at every sight.
        // consider custom model binding, value provider, authorization
        // filter and policy handler.
        //
        int? statEmployeeId = await User.GetAssociatedStatEmployeeIdAsync();

        if (statEmployeeId is null)
        {
            return Unauthorized("Can't find employee associated with provided credentials.");
        }

        var newReferralInfo = mapper.Map<ReferralInfo>(newReferral);

        var createdReferralInfo =
            await referralsApplication.AddReferralAsync(newReferralInfo, statEmployeeId.Value);

        // TODO: This is not the right place to do this, that's
        // just for simplicity. Use domain events
        // (e.g. NewReferralAddedEvent) to do this
        // asynchronously. I did first step towards this approach
        // by putting this logic not in the referrals app service
        // but in the log events app service. It's by design
        // that some "redundant" work is done here (like querying just
        // created referral and call) - this is for the sake of loose
        // coupling and SRP.
        await logEventsApplication.AddLogEventsOnNewReferralAsync(
            createdReferralInfo.ReferalId);

        var createdReferralViewModel = mapper.Map<CreatedReferralViewModel>(createdReferralInfo);

        return CreatedAtAction(
            nameof(FindByCallNumber),
            routeValues: new { createdReferralViewModel.CallNumber },
            value: createdReferralViewModel);
    }

    // Hide this api from swagger docs until it's implemented
    [ApiExplorerSettings(IgnoreApi = true)]
    [Authorize(AuthorizationPolicies.StatTracApiReferralRead)]
    [HttpGet("{callNumber}")]
    public async Task<ActionResult<ReferralViewModel>> FindByCallNumber(
         string callNumber,
         [FromServices] IMapper mapper)
    {
        return BadRequest("Not implemented yet");

        //var referral = await referralsApplication.FindByCallNumberAsync(callNumber);

        //if (referral == null)
        //{
        //    return NotFound();
        //}

        //var referralVm = mapper.Map<ReferralViewModel>(referral);

        //return mapper.Map<ReferralViewModel>(referralVm); ;
    }
}
