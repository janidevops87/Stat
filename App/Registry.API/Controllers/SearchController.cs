using System;
using System.Threading.Tasks;
using System.Web.Http;
using Registry.API.DAL;
using Registry.Common.DTO;

namespace Registry.API.Controllers
{
    [Authorize]
    public class SearchController : ApiBaseController<ISearchDataProvider>
    {
        public SearchController(ISearchDataProvider provider) :
            base(provider)
        {
        }

        [Route("search")]
        public async Task<IHttpActionResult> Get([FromUri] SearchRequest req)
        {
            var ret = await _dataProvider.SearchRegistry(req);

            return Ok(ret);
        }

        [Route("get-dla")]
        public async Task<IHttpActionResult> GetDla([FromUri] IdWrapperModel idModel)
        {
            var ret = await _dataProvider.SearchDlaRegistry(idModel.Id);

            return Ok(ret);
        }
    }
}
