using System.Collections.Generic;
using System.Threading.Tasks;
using Registry.Common.DTO;
using Registry.Common.Enums;
using Registry.Web.UI.ViewModels;

namespace Registry.Web.UI.DAL
{
    public interface IApiDataProvider
    {
        Task<AjaxResponseViewModel<List<SearchResult>>> SearchRegistry(SearchRequest registrySearchParams);
        Task<AjaxResponseViewModel<SearchResult>> SearchDlaRegistry(int id);
        Task<UserAuthenticationTicket> Login(string userName, string password);
        Task<List<EventCategorySelect>> GetEventCategories(GetEventCategoryRequest getEventCategoryRequest);
        Task<EventCategoryInsertUpdate> GetEventCategory(int id);
        Task<int> InsertEventCategory(EventCategoryInsertUpdate eventCategory);
        Task<bool> UpdateEventCategory(EventCategoryInsertUpdate eventCategory);
        Task<List<EventSubCategorySelect>> GetEventSubCategories(GetEventSubCategoryRequest getEventSubCategoryRequest);
        Task<EventSubCategoryInsertUpdate> GetEventSubCategory(int id);
        Task<int> InsertEventSubCategory(EventSubCategoryInsertUpdate eventSubCategory);
        Task<bool> UpdateEventSubCategory(EventSubCategoryInsertUpdate eventSubCategory);
        Task<List<string>> GetClientStates(GetClientStateRequest request);
        Task<List<EditCategoryModel>> GetEditCategories(int registryOwnerID);
        Task<List<RegistryEventCategory>> GetRegistryEventCategories(int registryOwnerID);
        Task<PostRegistryResponse> AddRegistration(Common.DTO.Registry registry, bool isDonor);
        Task<Common.DTO.Registry> GetRegistration(int id);
        Task<RegistrySignature> GetRegistrationSignature(int id);
        Task<RegistryApiError?> SignRegistration(int id, bool isDonor);
        Task<RegistryVerification> GetRegistrationVerification(RegistryVerificationRequest request);
        Task<IList<RegistryOwner>> GetRegistryOwners();
        Task<bool> SaveCategories(EditCategorySaveModel model);
        Task<PostRegistryResponse> IDologyVerification(IDologyAnswersRequest request);
        Task<IList<ReportDbEntity>> GetReportData(string states);
    }
}
