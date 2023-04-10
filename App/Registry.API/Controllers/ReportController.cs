using System.Threading.Tasks;
using System.Web.Http;
using Registry.API.DAL;
using Registry.Common.Constants;

namespace Registry.API.Controllers
{
    [Authorize]
    public class ReportController : ApiBaseController<IReportDataProvider>
    {
        public ReportController(IReportDataProvider provider) :
            base(provider)
        {
        }

        [HttpGet]
        [Route("report")]
        public async Task<IHttpActionResult> RegistryStatistics(string states)
        {
            var result = await _dataProvider.RegistryStatistics(states);

            return Ok(result);
        }
    }
}
