using System.Threading.Tasks;
using System.Web.Http;
using Registry.API.DAL;
using Registry.Common.DTO;

namespace Registry.API.Controllers
{
    [Authorize]
    public class CategoryController : ApiBaseController<ICategoryDataProvider>
    {
        public CategoryController(ICategoryDataProvider provider) :
            base(provider)
        {
        }

        [HttpGet]
        [Route("categories")]
        public async Task<IHttpActionResult> GetEventCategories([FromUri] GetEventCategoryRequest getEventCategoryRequest)
        {
            var result = await _dataProvider.GetEventCategories(getEventCategoryRequest ?? new GetEventCategoryRequest());

            return Ok(result);
        }

        [HttpGet]
        [Route("category")]
        public async Task<IHttpActionResult> GetEventCategory([FromUri] int id)
        {
            var result = await _dataProvider.GetEventCategory(id);

            if (result == null)
            {
                return NotFound();
            }

            return Ok(result);
        }

        [HttpPost]
        [Route("category")]
        public async Task<IHttpActionResult> PostEventCategory([FromBody] EventCategoryInsertUpdate eventCategory)
        {
            eventCategory.EventCategoryID = null;

            var result = await _dataProvider.InsertEventCategory(eventCategory);

            return Ok(result);
        }

        [HttpPut]
        [Route("category")]
        public async Task<IHttpActionResult> PutEventCategory([FromUri] int id, [FromBody] EventCategoryInsertUpdate eventCategory)
        {
            eventCategory.EventCategoryID = id;

            if (await _dataProvider.UpdateEventCategory(eventCategory) != 0)
            {
                return InternalServerError();
            }

            return Ok();
        }

        [HttpGet]
        [Route("subcategories")]
        public async Task<IHttpActionResult> GetEventSubCategories([FromUri] GetEventSubCategoryRequest getEventSubCategoryRequest)
        {
            var result = await _dataProvider.GetEventSubCategories(getEventSubCategoryRequest ?? new GetEventSubCategoryRequest());

            return Ok(result);
        }

        [HttpGet]
        [Route("subcategory")]
        public async Task<IHttpActionResult> GetEventSubCategory([FromUri] int id)
        {
            var result = await _dataProvider.GetEventSubCategory(id);

            if (result == null)
            {
                return NotFound();
            }

            return Ok(result);
        }

        [HttpPost]
        [Route("subcategory")]
        public async Task<IHttpActionResult> PostEventSubCategory([FromBody] EventSubCategoryInsertUpdate eventSubCategory)
        {
            eventSubCategory.EventSubCategoryID = null;

            var result = await _dataProvider.InsertEventSubCategory(eventSubCategory);

            return Ok(result);
        }

        [HttpPut]
        [Route("subcategory")]
        public async Task<IHttpActionResult> PutEventSubCategory([FromUri] int id, [FromBody] EventSubCategoryInsertUpdate eventSubCategory)
        {
            eventSubCategory.EventSubCategoryID = id;

            if (await _dataProvider.UpdateEventSubCategory(eventSubCategory) != 0)
            {
                return InternalServerError();
            }

            return Ok();
        }

        [HttpPut]
        [Route("categories-save")]
        public async Task<IHttpActionResult> CategoriesSave([FromBody] EditCategorySaveModel model)
        {
            await _dataProvider.SaveCategories(model);

            return Ok();
        }
    }
}
