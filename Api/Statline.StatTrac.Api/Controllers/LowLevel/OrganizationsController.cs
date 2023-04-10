using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Statline.StatTrac.Api.Common.Security;
using Statline.StatTrac.Api.ViewModels.LowLevel.Organizations;
using Statline.StatTrac.App.LowLevel.Organizations;
using Statline.StatTrac.Domain.Organizations;
using Statline.StatTrac.Domain.Phones;
using Statline.StatTrac.Domain.SubLocations;
using System.Linq;

namespace Statline.StatTrac.Api.Controllers.LowLevel;

[ApiVersion("1.0")]
[Route("api/v{version:apiVersion}/[controller]")]
[Authorize(AuthorizationPolicies.StatTracLowLevelApiPolicy)]
[ApiController]
public class OrganizationsController : ControllerBase
{
    private readonly OrganizationsApplication organizationsApplication;
    private readonly IMapper mapper;

    public OrganizationsController(
        OrganizationsApplication organizationsApplication,
        IMapper mapper)
    {
        this.organizationsApplication = Check.NotNull(organizationsApplication, nameof(organizationsApplication));
        this.mapper = Check.NotNull(mapper, nameof(mapper));
    }

    [HttpGet("filtered/ids", Name = nameof(GetFilteredOrganizationIds))]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public ActionResult<IAsyncEnumerable<int>> GetFilteredOrganizationIds(
        [FromQuery] OrganizationFilterCriteriaViewModel filterCriteriaViewModel)
    {
        var filterCriteria = mapper.Map<OrganizationFilterCriteria>(filterCriteriaViewModel);

        var ids = organizationsApplication.GetFilteredOrganizationIds(filterCriteria);

        return Ok(ids);
    }

    [HttpGet("filtered", Name = nameof(GetFilteredOrganizations))]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public ActionResult<IAsyncEnumerable<OrganizationViewModel>> GetFilteredOrganizations(
        [FromQuery] OrganizationFilterCriteriaViewModel filterCriteriaViewModel)
    {
        var filterCriteria = mapper.Map<OrganizationFilterCriteria>(filterCriteriaViewModel);

        var organizations = organizationsApplication.GetFilteredOrganizations(filterCriteria);

        return Ok(organizations.Select(o => mapper.Map<OrganizationViewModel>(o)));
    }

    [HttpGet("{organizationId:int}/sublocations/filtered", Name = nameof(GetFilteredSubLocations))]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public ActionResult<IAsyncEnumerable<SubLocationViewModel>> GetFilteredSubLocations(
        int organizationId, [FromQuery] SubLocationFilterCriteriaViewModel filterCriteriaViewModel)
    {
        var filterCriteria = mapper.Map<SubLocationFilterCriteria>(filterCriteriaViewModel);

        var subLocations = organizationsApplication.GetFilteredSubLocations(organizationId, filterCriteria);

        return Ok(subLocations.Select(o => mapper.Map<SubLocationViewModel>(o)));
    }

    [HttpGet("{organizationId:int}/phones/filtered", Name = nameof(GetFilteredPhones))]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public ActionResult<IAsyncEnumerable<PhoneViewModel>> GetFilteredPhones(
        int organizationId,
        [FromQuery] PhoneFilterCriteriaViewModel filterCriteriaViewModel)
    {
        var filterCriteria = mapper.Map<PhoneFilterCriteria>(filterCriteriaViewModel);

        var organizationPhones = organizationsApplication.GetFilteredPhones(organizationId, filterCriteria);

        return Ok(organizationPhones.Select(o => mapper.Map<PhoneViewModel>(o)));
    }

    [HttpGet("{organizationId:int}/phones/filtered/ids", Name = nameof(GetFilteredPhoneIds))]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public ActionResult<IAsyncEnumerable<int>> GetFilteredPhoneIds(
        int organizationId,
        [FromQuery] PhoneFilterCriteriaViewModel filterCriteriaViewModel)
    {
        var filterCriteria = mapper.Map<PhoneFilterCriteria>(filterCriteriaViewModel);

        var ids = organizationsApplication.GetFilteredOrganizationPhoneIds(organizationId, filterCriteria);

        return Ok(ids);
    }
}
