using System.Threading.Tasks;
using Registry.Common.DTO;

namespace Registry.API.DAL
{
    public interface IEnrollmentDataProvider
    {
        Task<Common.DTO.Registry> GetRegistry(int registryID);
        Task<Common.DTO.Registry> GetFullRegistry(int registryID);
        Task<int> InsertRegistry(Common.DTO.Registry registry);
        Task<int> InsertRegistryAddress(Common.DTO.Registry registry);
        Task<int> InsertRegistryEvent(Common.DTO.Registry registry);
        Task<RegistrySignature> GetRegistrySignature(int registryID);
        Task<int> ActivateRegistree(Common.DTO.Registry registry, bool isDonor);
        Task<int> DeactivateRegistree(Common.DTO.Registry registry);
        Task<RegistryVerification> GetRegistryVerification(RegistryVerificationRequest request);
        Task<int> GetExistingDonor(Common.DTO.Registry registry);
        Databases.Registry.Entities.RegistryOwner GetRegistryOwner(int registryOwnerID);
        Task<int> InsertIDologyLog(int registryID, string IDologyLogRequest, string IDologyLogResponse);
        Task<int> InsertRegistryDigitalCertificate(Common.DTO.Registry registry);
    }
}
