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
public class EmployeesController : ControllerBase
{
    private readonly PersonsApplication personsApplication;
    private readonly IMapper mapper;

    public EmployeesController(
        PersonsApplication personsApplication,
        IMapper mapper)
    {
        this.personsApplication = Check.NotNull(personsApplication, nameof(personsApplication));
        this.mapper = Check.NotNull(mapper, nameof(mapper));
    }

    [HttpGet("filtered/ids", Name = nameof(GetFilteredEmployeeIds))]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public ActionResult<IAsyncEnumerable<int>> GetFilteredEmployeeIds(
        [FromQuery] EmployeeFilterCriteriaViewModel filterCriteriaViewModel)
    {
        var filterCriteria = mapper.Map<EmployeeFilterCriteria>(filterCriteriaViewModel);

        var ids = personsApplication.GetFilteredEmployeeIds(filterCriteria);

        return Ok(ids);
    }

    [HttpGet("filtered", Name = nameof(GetFilteredEmployees))]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public ActionResult<IAsyncEnumerable<StatEmployeeViewModel>> GetFilteredEmployees(
        [FromQuery] EmployeeFilterCriteriaViewModel filterCriteriaViewModel)
    {
        var filterCriteria = mapper.Map<EmployeeFilterCriteria>(filterCriteriaViewModel);

        var employees = personsApplication.GetFilteredEmployees(filterCriteria);

        return Ok(employees.Select(e => mapper.Map<StatEmployeeViewModel>(e)));
    }
}
