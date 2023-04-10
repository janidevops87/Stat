using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Statline.StatTrac.Api.Common.Security;
using Statline.StatTrac.Api.ViewModels.EReferral;
using Statline.StatTrac.App.Enums;
using Statline.StatTrac.App.EReferrals;
using Statline.StatTrac.Domain.EReferrals;
using System.Linq;

namespace Statline.StatTrac.Api.Controllers;

[ApiVersion("1.0")]
[Route("api/v{version:apiVersion}/referrals")]
[Authorize(AuthorizationPolicies.StatTracLowLevelApiPolicy)]
[ApiController]
[ApiExplorerSettings(IgnoreApi = true)]
public class EReferralsController : ControllerBase
{
    private readonly EReferralsApplication ereferralsApplication;

    public EReferralsController(EReferralsApplication ereferralsApplication)
    {
        Check.NotNull(ereferralsApplication, nameof(ereferralsApplication));
        this.ereferralsApplication = ereferralsApplication;
    }

    [HttpGet]
    [Route("facilitycodes")]
    public async Task<ActionResult<List<FacilityInfo>>> GetFacilityCodes(string sourceCode)
    {
        return await ereferralsApplication.GetFacilityCodes(sourceCode);
    }

    [HttpGet]
    [Route("getsourcecodeid")]
    public async Task<ActionResult<int>> GetSourceCodeId(string sourceCode)
    {
        return await ereferralsApplication.GetSourceCodeId(sourceCode);
    }

    [HttpGet]
    [Route("contacttitlelist")]
    public async Task<ActionResult<List<ContactTitle>>> GetContactTitleList()
    {
        return await ereferralsApplication.GetContactTitleList();
    }

    [HttpGet]
    [Route("racelist")]
    public IAsyncEnumerable<EReferralRaceViewModel> GetRaceList(
        [FromServices] EnumsApplication enumsApplication,
        [FromServices] IMapper mapper)
    {
        var races = enumsApplication.GetAllRacesOrderedByNameAscending();
        return races.Select(race => mapper.Map<EReferralRaceViewModel>(race));
    }

    [HttpGet]
    [Route("hospitalunitlist")]
    public async Task<ActionResult<List<HospitalUnit>>> GetHospitalUnitList()
    {
        return await ereferralsApplication.GetHospitalUnitList();
    }
    //This checks for source code and facility code mappings, if contact exists for a facility 
    [HttpGet]
    [Route("facilityInfo")]
    public async Task<ActionResult<FacilityInfo?>> GetFacilityInfo(string sourceCode, string facilityCode, string? contactFirstName, string? contactLastName)
    {
        // TODO: Should return 404 (Not found) instead of null.
        return await ereferralsApplication.GetFacilityInfo(sourceCode, facilityCode, contactFirstName == "empty" ? null : contactFirstName, contactLastName == "empty" ? null : contactLastName);
    }

    [HttpGet]
    [Route("ismedicalrecordduplicate")]
    public async Task<ActionResult<bool>> IsMedicalRecordDuplicate(string sourceCode, string facilityCode, string medicalRecord)
    {
        return await ereferralsApplication.IsMedicalRecordDuplicate(sourceCode, facilityCode, medicalRecord);
    }

    [HttpGet]
    [Route("hospitalunitandfloor")]
    public async Task<ActionResult<HospitalUnitAndFloor?>> GetHospitalUnitAndFloor(string sourceCode, string facilityCode, string phone)
    {
        // TODO: Should return 404 (Not found) instead of null.
        return await ereferralsApplication.GetHospitalUnitAndFloor(sourceCode, facilityCode, phone);
    }

    [HttpPost]
    [Route("submitereferral")]
    public async Task<ActionResult<string?>> SubmitEreferral(ReferralModel referralModel)
    {
        return await ereferralsApplication.SubmitEreferral(referralModel);
    }
}