using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Statline.Ereferral.Web.Contexts;
using System.Linq;
using System.Threading.Tasks;

namespace DonorTrac.Web.Controllers
{
    [Route("api/[controller]")]
    public class AppSettingController : Controller
    {
        private ITransactionContext transactionContext;

        public AppSettingController(ITransactionContext _transactionContext)
        {
            transactionContext = _transactionContext;
        }

        //Confirmation
        [HttpGet("{key}")]
        public async Task<IActionResult> Get(string key)
        {
            var appSetting = await (from tbl in transactionContext.AppSetting select tbl)
                .Where(f => f.Key == key).FirstOrDefaultAsync();
            return Ok(new { value = appSetting.Value });
        }
    }
}