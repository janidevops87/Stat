using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Statline.StatTrac.Api.Common.Security;
using Statline.StatTrac.Api.ViewModels.HighLevel.Phones.Filtered;
using Statline.StatTrac.Api.ViewModels.HighLevel.Phones.NewPhone;
using Statline.StatTrac.App.HighLevel.Phones;
using Statline.StatTrac.Domain.Phones;
using Statline.StatTrac.Domain.Phones.Factory;

namespace Statline.StatTrac.Api.Controllers.HighLevel;

[ApiVersion("2.0")]
[Route("api/v{version:apiVersion}/organizations/{organizationId:int:min(1)}/phones")]
[ApiController]
public class OrganizationPhonesHighLevelController : ControllerBase
{
    public OrganizationPhonesHighLevelController()
    {
    }

    [Authorize(AuthorizationPolicies.StatTracApiPhoneCreate)]
    [HttpPost(Name = nameof(AddOrganizationPhone))]
    [ProducesResponseType(StatusCodes.Status201Created)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public async Task<ActionResult<int>> AddOrganizationPhone(
        int organizationId,
        PhoneViewModel newPhone,
        [FromServices] PhonesHighLevelApplication phonesApplication,
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

        var newPhoneInfo = mapper.Map<PhoneInfo>(newPhone);

        int createdPhoneId = await phonesApplication.AddOrganizationPhoneAsync(
            organizationId,
            newPhoneInfo,
            statEmployeeId.Value);

        return CreatedAtAction(
            nameof(FindOrganizationPhoneById),
            routeValues: new { PhoneId = createdPhoneId, OrganizationId = organizationId },
            value: createdPhoneId);
    }

    // Hide this api from swagger docs until it's implemented
    [ApiExplorerSettings(IgnoreApi = true)]
    [Authorize(AuthorizationPolicies.StatTracApiPhoneRead)]
    [HttpGet("{phoneId:int:min(1)}", Name = nameof(FindOrganizationPhoneById))]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public ActionResult FindOrganizationPhoneById(
        int organizationId,
        int phoneId)
    {
        return BadRequest("Not implemented yet");
    }

    [HttpGet("filtered/ids", Name = nameof(GetIdsOfFilteredOrganizationPhones))]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [Authorize(AuthorizationPolicies.StatTracApiPhoneRead)]
    public ActionResult<IAsyncEnumerable<int>> GetIdsOfFilteredOrganizationPhones(
        int organizationId,
        [FromQuery] PhoneFilterCriteriaViewModel filterCriteriaViewModel,
        [FromServices] PhonesHighLevelApplication phonesApplication,
        [FromServices] IMapper mapper)
    {
        var filterCriteria = mapper.Map<PhoneFilterCriteria>(filterCriteriaViewModel);

        var ids = phonesApplication.GetFilteredOrganizationPhoneIds(organizationId, filterCriteria);

        return Ok(ids);
    }
}
