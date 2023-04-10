using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Statline.StatTrac.Api.Common.Security;
using Statline.StatTrac.Api.ViewModels.LowLevel.Persons;
using Statline.StatTrac.App.LowLevel.Persons;
using Statline.StatTrac.Domain.Persons;
using System.Linq;

namespace Statline.StatTrac.Api.Controllers.LowLevel;

[ApiVersion("1.0")]
[Route("api/v{version:apiVersion}/[controller]")]
[Authorize(AuthorizationPolicies.StatTracLowLevelApiPolicy)]
[ApiController]
public class PersonsController : ControllerBase
{
    private readonly PersonsApplication personsApplication;
    private readonly IMapper mapper;

    public PersonsController(
        PersonsApplication personsApplication,
        IMapper mapper)
    {
        this.personsApplication = Check.NotNull(personsApplication, nameof(personsApplication));
        this.mapper = Check.NotNull(mapper, nameof(mapper));
    }

    [HttpGet("filtered/ids", Name = nameof(GetFilteredPersonIds))]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public ActionResult<IAsyncEnumerable<int>> GetFilteredPersonIds(
        [FromQuery] PersonFilterCriteriaViewModel filterCriteriaViewModel,
        bool ordered)
    {
        var filterCriteria = mapper.Map<PersonFilterCriteria>(filterCriteriaViewModel);

        IAsyncEnumerable<int> ids;

        if (ordered)
        {
            ids = personsApplication.GetFilteredPersonIdsOrdered(filterCriteria);
        }
        else
        {
            ids = personsApplication.GetFilteredPersonIds(filterCriteria);
        }

        return Ok(ids);
    }

    [HttpGet("filtered", Name = nameof(GetFilteredPersons))]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public ActionResult<IAsyncEnumerable<PersonViewModel>> GetFilteredPersons(
        [FromQuery] PersonFilterCriteriaViewModel filterCriteriaViewModel,
        bool ordered)
    {
        var filterCriteria = mapper.Map<PersonFilterCriteria>(filterCriteriaViewModel);

        IAsyncEnumerable<PersonInfo> persons;

        if (ordered)
        {
            persons = personsApplication.GetFilteredPersonsOrdered(filterCriteria);
        }
        else
        {
            persons = personsApplication.GetFilteredPersons(filterCriteria);
        }

        return Ok(persons.Select(e => mapper.Map<PersonViewModel>(e)));
    }
}
