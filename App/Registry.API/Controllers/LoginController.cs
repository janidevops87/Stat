namespace Registry.API.Controllers
{
    using System.Threading.Tasks;
    using System.Web.Http;
    using DAL;

    public class LoginController : ApiBaseController<ISecurityDataProvider>
    {
        public LoginController(ISecurityDataProvider provider) :
            base(provider)
        {
        }

        [Route("login")]
        [HttpGet]
        public async Task<IHttpActionResult> Login(string userName, string password)
        {
            var login = await _dataProvider.Login(userName, password);

            return Ok(login);
        }

        [Route("owners")]
        [HttpGet]
        public async Task<IHttpActionResult> GetRegistryOwners()
        {
            var result = await _dataProvider.GetClients();

            return Ok(result);
        }
    }
}
