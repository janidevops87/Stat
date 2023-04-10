using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Newtonsoft.Json.Linq;
using Statline.Ereferral.Web;
using Statline.Ereferral.Web.Services;
using System.Configuration;
using System.Threading.Tasks;

namespace DonorTrac.Web.Controllers
{
    [Route("api/[controller]")]
    public class ServerController : Controller
    {
        private IStattracApi _statTracApi;
        private readonly ILogger _logger;
        private EreferralSettings ereferralSettings;

        public ServerController(IStattracApi statTracApi, ILogger<ServerController> logger,
            IOptions<EreferralSettings> setting)
        {
            _statTracApi = statTracApi;
            _logger = logger;
            ereferralSettings = setting.Value;
        }
        [HttpGet("version")]
        public async Task<IActionResult> GetVersion()
        {
            return Json(await _statTracApi.GetVersion());
        }
        [HttpGet("IsAvailable")]
        public async Task<IActionResult> IsAvailable()
        {
            if (!(await _statTracApi.IsIdentityServerAvailableAsync()))
            {
                return Ok(false);
            }
            if (!(await _statTracApi.IsStatTracApiAvailableAsync()))
            {
                return Ok(false);
            }
            return Ok(true);
        }

        [HttpGet("unosIdExists")]
        public async Task<IActionResult> UnosIdExists(string unosid)
        {
            return Ok(await _statTracApi.UnosIdExists(unosid));
        }

        [HttpGet("log")]
        public async Task<IActionResult> AddLog(string message)
        {
            await Task.Run(() => _logger.LogInformation(message));
            return Ok(true);
        }

        [HttpGet("GetSourceCodeId")]
        public async Task<IActionResult> IsSourceCodeValid(string sourceCode)
        {
            return Ok(await _statTracApi.GetSourceCodeId(sourceCode));
        }

        [HttpGet("IsMedicalRecordDuplicate")]
        public async Task<IActionResult> IsMedicalRecordDuplicate(string sourceCode, string facilityCode, string medicalRecord)
        {
            return Ok(await _statTracApi.IsMedicalRecordDuplicate(sourceCode, facilityCode, medicalRecord));
        }
        //This checks for source code and facility code mappings, if contact exists for a facility 
        [HttpGet("facilityinfo")]
        public async Task<IActionResult> GetFacilityInfo(string sourceCode, string facilityCode, string contactFirstName, string contactLastName)
        {
             string str = await _statTracApi.GetFacilityInfo(sourceCode, facilityCode, contactFirstName, contactLastName);
            if (str == "")
                return Ok(Json("{\"contactTitleId\": null}"));
            JObject json = JObject.Parse(str);
            return Ok(Json(json.ToString()));
        }

        [HttpGet("hospitalunitandfloor")]
        public async Task<IActionResult> GetHospitalUnitAndFloor(string sourceCode, string facilityCode, string phone)
        {
            string str = await _statTracApi.GetHospitalUnitAndFloor(sourceCode, facilityCode, phone);
            return Ok(Json(str));
        }
    }
}