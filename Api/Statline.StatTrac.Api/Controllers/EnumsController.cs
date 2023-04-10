using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Statline.StatTrac.Api.Common.Security;
using Statline.StatTrac.Api.ViewModels.Enums;
using Statline.StatTrac.App.Enums;
using System.Linq;

namespace Statline.StatTrac.Api.Controllers;

[ApiVersion("1.0")]
[Route("api/v{version:apiVersion}")]
[Authorize(AuthorizationPolicies.StatTracLowLevelApiPolicy)]
[ApiController]
public class EnumsController : ControllerBase
{
    private readonly EnumsApplication enumsApplication;
    private readonly IMapper mapper;

    public EnumsController(
        EnumsApplication enumsApplication,
        IMapper mapper)
    {
        this.enumsApplication = Check.NotNull(enumsApplication, nameof(enumsApplication));
        this.mapper = Check.NotNull(mapper, nameof(mapper));
    }

    [HttpGet("causesofdeath", Name = nameof(GetAllCausesOfDeath))]
    public IAsyncEnumerable<EnumValueViewModel> GetAllCausesOfDeath()
    {
        var causesOfDeath = enumsApplication.GetAllCausesOfDeath();
        return causesOfDeath.Select(cod => mapper.Map<EnumValueViewModel>(cod));
    }

    [HttpGet("races", Name = nameof(GetAllRaces))]
    public IAsyncEnumerable<EnumValueViewModel> GetAllRaces()
    {
        var races = enumsApplication.GetAllRaces();
        return races.Select(race => mapper.Map<EnumValueViewModel>(race));
    }
}
