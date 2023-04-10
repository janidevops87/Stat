using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Statline.Ereferral.Web.Services;
using System.Threading.Tasks;

namespace DonorTrac.Web.Controllers
{
    [Route("api/[controller]")]
    public class FileUploadController : Controller
    {
        private IStattracApi _donorTracApi;

        public FileUploadController(IStattracApi donorTracApi)
        {
            _donorTracApi = donorTracApi;
        }

        [HttpPost()]
        [RequestSizeLimit(20_000_000)]
        public async Task<IActionResult> Add(IFormFile file)
        {
            if (file == null)
            {
                return BadRequest(ModelState);
            }

            var content = await _donorTracApi.FileUpload(file);
            if (content.IsSuccessStatusCode)
            {
                return Ok(await content.Content.ReadAsStringAsync());
            }
            else
            {
                return BadRequest(content.Content.ReadAsStringAsync());
            }
        }
    }
}