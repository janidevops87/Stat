using System.Linq;
using System.Threading.Tasks;
using System.Web.Http;
using Registry.API.DAL;
using Registry.Common.Constants;
using Registry.Common.DTO;
using Registry.Common.Enums;
using Registry.API.Idology;
using Registry.Common.Idology;

namespace Registry.API.Controllers
{
    [Authorize]
    public class EnrollmentController : ApiBaseController<IEnrollmentDataProvider>
    {
        public EnrollmentController(IEnrollmentDataProvider provider) :
            base(provider)
        {
        }

        [HttpGet]
        [Route(Routes.RouteEnrollment)]
        public async Task<IHttpActionResult> GetRegistry([FromUri] int registryID)
        {
            var result = await _dataProvider.GetFullRegistry(registryID);

            return Ok(result);
        }

        [HttpPost]
        [Route(Routes.RouteEnrollment)]
        [Route(Routes.RouteRemoval)]
        public async Task<IHttpActionResult> PostRegistry([FromBody] Common.DTO.Registry request)
        {
            request.RegistryID = null;

            var result = new PostRegistryResponse { RegistryApiResult = RegistryApiError.NoError };

            result.RegistryID = await _dataProvider.InsertRegistry(request);

            request.RegistryID = result.RegistryID;

            Task<int> addressTask, eventTask;

            await Task.WhenAll(
                addressTask = _dataProvider.InsertRegistryAddress(request),
                eventTask = _dataProvider.InsertRegistryEvent(request)
            );

            if ((addressTask.Result != 0) || (eventTask.Result != 0))
            {
                return InternalServerError();
            }

            if (RequestContext.RouteData.Route.RouteTemplate == Routes.RouteRemoval)
            {
                //TODO: think about a common data provider for shared data required in multiple controllers. bypassing IOC here.
                var clientsConfig = await new EFSecurityDataProvider().GetClients();
                var isRemovalNonDonorAllowed = (clientsConfig.Single(x => x.RegistryOwnerId == request.RegistryOwnerID).AllowDisplayNoDonors == true);

                if ((isRemovalNonDonorAllowed == false) && (await _dataProvider.GetExistingDonor(request) == EFEnrollmentDataProvider.NoDonorRecordsFound))
                {
                    result.RegistryApiResult = RegistryApiError.VerificationFailed;

                    return Ok(result);
                }
            }

            return Ok(new IdologyApiClient().VerifyRegistrant(_dataProvider, request));
        }

        [HttpPost]
        [Route("idology/answers")]
        public async Task<IHttpActionResult> PostIDologyAnswers([FromBody] IDologyAnswersRequest request)
        {
            var registry = await _dataProvider.GetRegistry(request.RegistryID);

            return Ok(new IdologyApiClient().VerifyAnswers(_dataProvider, request, registry.RegistryOwnerID.Value));
        }

        [HttpGet]
        [Route(Routes.RouteEnrollmentSignature)]
        [Route(Routes.RouteRemovalSignature)]
        public async Task<IHttpActionResult> GetRegistrySignature([FromUri] int registryID)
        {
            var result = await _dataProvider.GetRegistrySignature(registryID);

            return Ok(result);
        }

        [HttpPut]
        [Route(Routes.RouteEnrollmentSignature)]
        [Route(Routes.RouteRemovalSignature)]
        public async Task<IHttpActionResult> PutRegistrySignature([FromUri] int registryID)
        {
            var registry = await _dataProvider.GetRegistry(registryID);
            var existingDonorId = await _dataProvider.GetExistingDonor(registry);

            if (existingDonorId == EFEnrollmentDataProvider.MultipleDonorRecordsFound)
            {
                return Ok(RegistryApiError.VerificationFailed);
            }

            if (existingDonorId > 0)
            {
                var existingDonor = await _dataProvider.GetRegistry(existingDonorId);

                if (await _dataProvider.DeactivateRegistree(existingDonor) != 0)
                {
                    return InternalServerError();
                }
            }

            var isDonor = (RequestContext.RouteData.Route.RouteTemplate == Routes.RouteEnrollmentSignature);

            if (isDonor == false)
            {
                //TODO: think about a common data provider for shared data required in multiple controllers. bypassing IOC here.
                var clientsConfig = await new EFSecurityDataProvider().GetClients();
                var shouldNotActivateRemoval = (clientsConfig.Single(x => x.RegistryOwnerId == registry.RegistryOwnerID).AllowDisplayNoDonors == false);

                if (shouldNotActivateRemoval == true)
                {
                    return Ok(RegistryApiError.NoError);
                }
            }

            Task<int> activationTask, certificateTask;

            await Task.WhenAll(
                activationTask = _dataProvider.ActivateRegistree(registry, isDonor),
                certificateTask = _dataProvider.InsertRegistryDigitalCertificate(registry)
            );

            if ((activationTask.Result != 0) || (certificateTask.Result != 0))
            {
                return InternalServerError();
            }

            return Ok(RegistryApiError.NoError);
        }

        [HttpGet]
        [Route("enrollment/verification")]
        public async Task<IHttpActionResult> GetRegistryVerification([FromUri] RegistryVerificationRequest request)
        {
            var result = await _dataProvider.GetRegistryVerification(request ?? new RegistryVerificationRequest());

            return Ok(result);
        }
    }
}
