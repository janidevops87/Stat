using System.Collections.Generic;
using System.Threading.Tasks;
using Registry.Common.DTO;

namespace Registry.API.DAL
{
    public interface ICategoryDataProvider
    {
        Task<IEnumerable<EventCategorySelect>> GetEventCategories(GetEventCategoryRequest getEventCategoryRequest);
        Task<EventCategoryInsertUpdate> GetEventCategory(int eventCategoryId);
        Task<int> InsertEventCategory(EventCategoryInsertUpdate eventCategory);
        Task<int> UpdateEventCategory(EventCategoryInsertUpdate eventCategory);
        Task<IEnumerable<EventSubCategorySelect>> GetEventSubCategories(GetEventSubCategoryRequest getEventSubCategoryRequest);
        Task<EventSubCategoryInsertUpdate> GetEventSubCategory(int eventSubCategoryId);
        Task<int> InsertEventSubCategory(EventSubCategoryInsertUpdate eventSubCategory);
        Task<int> UpdateEventSubCategory(EventSubCategoryInsertUpdate eventSubCategory);
        Task SaveCategories(EditCategorySaveModel categories);
    }
}
