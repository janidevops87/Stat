namespace Registry.API.Controllers
{
    using DAL;
    using System.Web.Http;

    public class ApiBaseController<TDataProvider> : ApiController
    {
        protected readonly TDataProvider _dataProvider;

        protected ApiBaseController(TDataProvider provider)
        {
            _dataProvider = provider;
        }
    }
}
