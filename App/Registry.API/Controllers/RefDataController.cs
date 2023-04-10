using System.Threading.Tasks;
using System.Web.Http;
using Registry.API.DAL;
using Registry.Common.DTO;

namespace Registry.API.Controllers
{
    [Authorize]
    public class RefDataController : ApiBaseController<IRefDataProvider>
    {
        public RefDataController(IRefDataProvider provider) :
            base(provider)
        {
        }

        [HttpGet]
        [Route("clientstates")]
        public async Task<IHttpActionResult> GetClientStates([FromUri] GetClientStateRequest request)
        {
            var result = await _dataProvider.GetClientStates(request ?? new GetClientStateRequest());

            return Ok(result);
        }

        [HttpGet]
        [Route("registrycategories")]
        public async Task<IHttpActionResult> GetRegistryEventCategories([FromUri] int registryOwnerID)
        {
            var result = await _dataProvider.GetRegistryEventCategories(registryOwnerID);

            return Ok(result);
        }

        [HttpGet]
        [Route("editcategories")]
        public async Task<IHttpActionResult> GetEditCategories([FromUri] int registryOwnerID)
        {
            var result = await _dataProvider.GetAllEventCategories(registryOwnerID);

            return Ok(result);
        }
    }
}
