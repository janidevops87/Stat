using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Statline.StatTrac.Api.Common.Security;
using Statline.StatTrac.Api.ViewModels.LowLevel.Referrals;
using Statline.StatTrac.App.LowLevel.Referrals;
using Statline.StatTrac.Domain.Referrals;
using System.Linq;

namespace Statline.StatTrac.Api.Controllers.LowLevel;

/// <summary>Referrals Controller</summary>
/// <remarks>
/// Date/time should be provided in the round-trip format (ISO 8601).
/// Here are some examples and how they are treated by the API:
/// 
/// 1. Local date/time: 2017-10-25T01:00:00-07:00.
/// Here you provide date/time in your time zone, specifying time zone offset.
/// 
/// 2. UTC date/time: 2017-10-25T01:00:00Z.
/// No time zone offset provided, the 'Z' at the end is important.
/// The same effect has case 1 with offset 00:00.
/// 
/// 3. Unspecified date/time kind: 2017-10-25T01:00:00.
/// In this case, server has no idea how treat this date/time, so it will
/// fall back to its default - will treat it as date/time local to the
/// SERVER's time zone. E.g. if server machine is set up with time zone 
/// offset +03:00, full date/time it will use in our example will look like
/// 2017-10-25T01:00:00+03:00, which may be quite not what you want.
/// So generally this format should be avoided.
/// </remarks>
[ApiVersion("1.0")]
[Route("api/v{version:apiVersion}/[controller]")]
// This default policy is more relaxed, it doesn't require WebReportGroupId.
// We add more strict policies to actions which need them.
[Authorize(AuthorizationPolicies.StatTracLowLevelApiPolicy)]
[ApiController]
public class ReferralsController : ControllerBase
{
    private readonly ReferralsApplication referralsApplication;

    public ReferralsController(ReferralsApplication referralsApplication)
    {
        Check.NotNull(referralsApplication, nameof(referralsApplication));
        this.referralsApplication = referralsApplication;
    }

    /// <summary>
    /// Returns referrals which have been updated since the specified time.
    /// </summary>
    /// <param name="sinceTime">
    /// The date/time of oldest update to start with.
    /// </param>
    /// <returns>
    /// A collection of referral IDs. Use <see cref="GetReferralDetail"/>
    /// to get each referral details.
    /// </returns>
    // TODO: We need to decide whether we still need this API. For now
    // commenting it out to avoid interference with another API (below).
    //[Authorize(AuthorizationPolicies.StatTracReferralApiClientPolicy)]
    //[HttpGet("updated")]
    //public async Task<IEnumerable<int>> GetUpdatedReferrals(DateTimeOffset sinceTime)
    //{
    //    var referralIds =
    //        await referralsApplication.GetUpdatedReferralsAsync(sinceTime);

    //    return referralIds.Select(r => r.Value);
    //}

    /// <summary>
    /// Returns referrals which have been updated within specified time frame.
    /// </summary>
    /// <param name="from">The date/time of the oldest update.</param>
    /// <param name="to">The date/time of the latest update.</param>
    /// <returns>
    /// A collection of referral IDs. Use <see cref="GetReferralDetail"/>
    /// to get each referral details.
    /// </returns>
    [Authorize(AuthorizationPolicies.StatTracApiWithWebReportGroupIdPolicy)]
    [HttpGet("updated")]
    public async Task<IEnumerable<int>> GetUpdatedReferrals(
        DateTimeOffset from,
        DateTimeOffset to)
    {
        var referralIds =
            await referralsApplication.GetUpdatedReferralsAsync(from, to);

        return referralIds.Select(r => r.Value);
    }

    /// <summary>
    /// Returns referrals that have occurred within a specified time range.
    /// </summary>       
    /// <param name="from">The date/time of the oldest call.</param>
    /// <param name="to">The date/time of the latest call.</param>
    /// <returns>
    /// A collection of referral IDs. Use <see cref="GetReferralDetail"/>
    /// to get each referral details.
    /// </returns>
    // TODO: Consider making returned model richer and include links to details.
    // For example, it would be very RESTful if result looked like:
    // [
    //   {
    //      "id":12345,
    //      "links":[{"rel":"details", "href":"/api/v1.0/referrals/12345", "method":"get"}]
    //   }            
    // ]
    // If we expect to have lots of IDs returned and decide to add paging,
    // the "links" would also provide "previous", "next", "first", "last" links for this.
    //
    // More on this concept: https://en.wikipedia.org/wiki/HATEOAS
    [Authorize(AuthorizationPolicies.StatTracApiWithWebReportGroupIdPolicy)]
    [HttpGet("bycalldatetime")]
    public async Task<IEnumerable<int>> GetReferralsByCallDateTime(
        DateTimeOffset from,
        DateTimeOffset to)
    {
        // TODO: Consider adding some validation
        // for parameter, e.g. to >= from.

        var referralIds = await referralsApplication
            .GetReferralsWithCallsInDateRangeAsync(from, to);

        return referralIds.Select(r => r.Value);
    }

    /// <summary>
    /// Retrieves referral details.
    /// </summary>
    /// <param name="referralId">The ID of the referral.</param>
    /// <returns>
    /// A referral details object.
    /// </returns>
    /// <response code="200">Returns existing referral details.</response>
    /// <response code="404">Referral with given ID was not found.</response>            
    // TODO: Create a route constraint for ReferralId type
    // and make the parameter to be of type ReferralId instead of int
    // (will probably require custom binder or type converter).
    // Currently the constraints below essentially repeat business
    // rules which ReferralId already enforces.
    [Authorize(AuthorizationPolicies.StatTracApiWithWebReportGroupIdPolicy)]
    [HttpGet("{referralId:int:min(1)}/details")]
    public async Task<ActionResult<ReferralDetails>> GetReferralDetail(int referralId)
    {
        var referral = await referralsApplication
            .GetReferralDetailsByIdAsync(new ReferralId(referralId));

        if (referral == null)
        {
            return NotFound();
        }

        // TODO: use view model instead of directly 
        // returning domain object (requires mapping).
        return referral;
    }

    [HttpGet("duplicate")]
    public IAsyncEnumerable<int> GetDuplicateReferrals(
        [FromQuery] DuplicateReferralsFilterCriteriaViewModel filterCriteriaViewModel,
        [FromServices] IMapper mapper)
    {
        var filterCriteria = mapper.Map<DuplicateReferralsFilterCriteria>(filterCriteriaViewModel);

        var referralIds = referralsApplication.GetDuplicateReferrals(filterCriteria);

        return referralIds.Select(r => r.Value);
    }

    [HttpPost(Name = nameof(AddReferral))]
    [ProducesResponseType(StatusCodes.Status201Created)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public async Task<ActionResult<int>> AddReferral(
        NewReferralViewModel newReferral,
        [FromServices] IMapper mapper)
    {
        var newReferralInfo = mapper.Map<App.LowLevel.Referrals.NewReferralInfo>(newReferral);

        ReferralId referralId = await referralsApplication.AddReferralAsync(newReferralInfo);

        return CreatedAtAction(
            nameof(GetReferralDetail),
            routeValues: new { ReferralId = referralId.Value },
            value: referralId.Value);
    }

    /// <summary>
    /// Retrieves referral.
    /// </summary>
    /// <param name="referralId">The ID of the referral.</param>
    /// <param name="mapper">Object mapper.</param>
    /// <returns>
    /// A referral object.
    /// </returns>
    /// <response code="200">Returns existing referral details.</response>
    /// <response code="404">Referral with given ID was not found.</response>            
    // TODO: Create a route constraint for ReferralId type
    // and make the parameter to be of type ReferralId instead of int
    // (will probably require custom binder or type converter).
    // Currently the constraints below essentially repeat business
    // rules which ReferralId already enforces.
    [Authorize(AuthorizationPolicies.StatTracLowLevelApiPolicy)]
    [HttpGet("{referralId:int:min(1)}")]
    public async Task<ActionResult<ReferralViewModel>> FindByReferralId(
        int referralId,
        [FromServices] IMapper mapper)
    {
        var referral = await referralsApplication
            .FindReferralByIdAsync(new ReferralId(referralId));

        if (referral == null)
        {
            return NotFound();
        }

        var referralVm = mapper.Map<ReferralViewModel>(referral);

        return mapper.Map<ReferralViewModel>(referralVm); ;
    }
}