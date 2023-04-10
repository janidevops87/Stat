using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Statline.StatTrac.Api.Common.Security;
using Statline.StatTrac.Api.ViewModels.HighLevel.Persons.Filtered;
using Statline.StatTrac.Api.ViewModels.HighLevel.Persons.NewPerson;
using Statline.StatTrac.App.HighLevel.Persons;
using Statline.StatTrac.Domain.Persons;
using Statline.StatTrac.Domain.Persons.Factory;
using System.Linq;

namespace Statline.StatTrac.Api.Controllers.HighLevel;

[ApiVersion("2.0")]
[Route("api/v{version:apiVersion}/organizations/{organizationId:int:min(1)}/persons")]
[ApiController]
public class PersonsHighLevelController : ControllerBase
{
    public PersonsHighLevelController()
    {
    }

    [Authorize(AuthorizationPolicies.StatTracApiPersonCreate)]
    [HttpPost(Name = nameof(AddPerson))]
    [ProducesResponseType(StatusCodes.Status201Created)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public async Task<ActionResult<int>> AddPerson(
        int organizationId,
        PersonViewModel newPerson,
        [FromServices] PersonsHighLevelApplication personsApplication,
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

        var newPersonInfo = mapper.Map<PersonInfo>(newPerson);

        int createdPersonId = await personsApplication.AddPersonAsync(
            organizationId,
            newPersonInfo,
            statEmployeeId.Value);

        return CreatedAtAction(
            nameof(FindPersonById),
            routeValues: new { PersonId = createdPersonId, OrganizationId = organizationId },
            value: createdPersonId);
    }

    // Hide this api from swagger docs until it's implemented
    [ApiExplorerSettings(IgnoreApi = true)]
    [Authorize(AuthorizationPolicies.StatTracApiPersonRead)]
    [HttpGet("{personId:int:min(1)}", Name = nameof(FindPersonById))]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public ActionResult FindPersonById(int personId)
    {
        return BadRequest("Not implemented yet");
    }

    [HttpGet("filtered/ids", Name = nameof(GetIdsOfFilteredPersons))]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [Authorize(AuthorizationPolicies.StatTracApiPersonRead)]
    public ActionResult<IAsyncEnumerable<int>> GetIdsOfFilteredPersons(
        int organizationId,
        [FromQuery] PersonFilterCriteriaViewModel filterCriteriaViewModel,
        bool ordered,
        [FromServices] PersonsHighLevelApplication personsApplication)
    {
        var filterCriteria = new PersonFilterCriteria(
            filterCriteriaViewModel.FirstName,
            filterCriteriaViewModel.LastName,
            organizationId,
            filterCriteriaViewModel.ActiveState);

        IAsyncEnumerable<PersonId> ids;

        if (ordered)
        {
            ids = personsApplication.GetIdsOfFilteredPersonsOrdered(filterCriteria);
        }
        else
        {
            ids = personsApplication.GetIdsOfFilteredPersons(filterCriteria);
        }

        return Ok(ids.Select(id => id.Value));
    }
}
