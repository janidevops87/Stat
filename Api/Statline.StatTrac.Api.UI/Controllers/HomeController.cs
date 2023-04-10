using IdentityModel;
using IdentityModel.Client;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Statline.StatTrac.Api.UI.App.Configuration;
using System.Collections.Generic;
using System.Configuration;
using System.Net.Http;
using System.Threading.Tasks;

namespace Statline.StatTrac.Api.UI.Controllers
{
    [Authorize]
    public class HomeController : Controller
    {
        private readonly AppSettings _settings;

        public HomeController(IOptions<AppSettings> settings)
        {
            _settings = settings.Value;
        }
       
        public IActionResult Index()
        {
            return View();
        }

      
        public IActionResult Error()
        {
            return View();
        }

      
        public async Task<IActionResult> CallHeartbeat()
        {
            var accessToken = await HttpContext.GetTokenAsync("access_token");

            //// call api
            var client = new HttpClient();
            client.SetBearerToken(accessToken);

            var content = await client.GetStringAsync(_settings.StatlineStatTracApiUri + "api/v1.0/heartbeat");

            ViewBag.Json = content;
            return View("json");
        }

        public async Task<IActionResult> CallReferralNext()
        {
            var accessToken = await HttpContext.GetTokenAsync("access_token");

            //// call api
            var client = new HttpClient();
            client.SetBearerToken(accessToken);

            var content = await client.GetStringAsync(_settings.StatlineStatTracApiUri + "api/v1.0/referrals/updated?sinceTime=2017-08-24");

            ViewBag.Json = content;
            return View("json");
        }

        public async Task<IActionResult> CallApiUsingUserAccessToken()
        {
            var accessToken = await HttpContext.GetTokenAsync("access_token");

            var client = new HttpClient();
            client.SetBearerToken(accessToken);
            var content = await client.GetStringAsync(_settings.StatlineStatTracApiUri + "identity");

            ViewBag.Json = JArray.Parse(content).ToString();
            return View("json");
        }
    }
}
