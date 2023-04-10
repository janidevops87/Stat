using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using Statline.Ereferral.Models;
using Statline.Ereferral.Web;
using Statline.Ereferral.Web.Contexts;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;

namespace DonorTrac.Web.Controllers
{
    [Route("api/[controller]")]
    public class EmailVerificationController : Controller
    {
        private UserManager<EreferralUser> _userManager;
        private SignInManager<EreferralUser> _signInManager;
        private EreferralSettings _setting;

        public EmailVerificationController(UserManager<EreferralUser> userManager, SignInManager<EreferralUser> signInManager,
            IOptions<EreferralSettings> setting)
        {
            _userManager = userManager;
            _signInManager = signInManager;
            _setting = setting.Value;
        }

        [HttpPost()]
        public async Task<IActionResult> Post([FromBody]ReferralModel model)
        {
            if (model == null || !ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            return Ok();

        }
    }
}