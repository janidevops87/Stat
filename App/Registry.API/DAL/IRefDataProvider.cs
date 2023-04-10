using System.Collections.Generic;
using System.Threading.Tasks;
using Registry.Common.DTO;

namespace Registry.API.DAL
{
    public interface IRefDataProvider
    {
        Task<IEnumerable<string>> GetClientStates(GetClientStateRequest getClientStateRequest);
        Task<IEnumerable<EditCategoryModel>> GetAllEventCategories(int registryOwnerID);
        Task<IEnumerable<RegistryEventCategory>> GetRegistryEventCategories(int registryOwnerID);
    }
}
