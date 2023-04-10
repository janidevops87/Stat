using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using Statline.Ereferral.Web.Services;
using System.Threading.Tasks;

namespace Statline.Ereferral.Web.Controllers
{
    [Route("api/[controller]")]
    public class ListController : Controller
    {
        private IStattracApi _statTracApi;

        public ListController(IOptions<EreferralSettings> setting, IStattracApi donorTracApi)
        {
            _statTracApi = donorTracApi;
        }

        [HttpGet("titles")]
        public async Task<IActionResult> Titles()
        {
            return Ok(await _statTracApi.Titles());
        }

        [HttpGet("races")]
        public async Task<IActionResult> Races()
        {
            return Ok(await _statTracApi.Races());
        }

        [HttpGet("hospitalunits")]
        public async Task<IActionResult> HospitalUnits()
        {
            return Ok(await _statTracApi.HospitalUnits());
        }

        [HttpGet("facilitycodes")]
        public async Task<IActionResult> GetFacilityCodes(string sourceCode)
        {
            return Ok(await _statTracApi.GetFacilityCodes(sourceCode));
        }

        [HttpGet("OfferedOrganTissue")]
        public async Task<IActionResult> OfferedOrganTissue()
        {
            return Ok(await _statTracApi.OfferedOrganTissue());
        }
    }
}