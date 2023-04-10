using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using Statline.Ereferral.Models;
using Statline.Ereferral.Web;
using Statline.Ereferral.Web.Contexts;
using Statline.Ereferral.Web.Services;
using Statline.Ereferral.Web.Validators;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace DonorTrac.Web.Controllers
{
    [Route("api/[controller]")]
    public class ReferralController : Controller
    {
        private UserManager<EreferralUser> _userManager;
        private SignInManager<EreferralUser> _signInManager;
        private LoginValidator _validator;
        private IStattracApi _statTracApi;
        private EreferralSettings ereferralSettings;
        public ReferralController(UserManager<EreferralUser> userManager, SignInManager<EreferralUser> signInManager,
             IOptions<EreferralSettings> setting, IStattracApi statTracApi)
        {
            _userManager = userManager;
            _signInManager = signInManager;
            _validator = new LoginValidator(setting.Value, statTracApi);
            _statTracApi = statTracApi;
            ereferralSettings = setting.Value;
        }

        [HttpPost()]
        public async Task<IActionResult> Post([FromBody]ReferralModel model)
        {
            if (model == null || !ModelState.IsValid || !(await _validator.IsValid(model, ModelState)))
            {
                return BadRequest(ModelState);
            }
            model.statEmployeeId = ereferralSettings.StattracUserId;
            var ret = await _statTracApi.SubmitEreferral(model);
            return Json(ret);
        }
    }
}