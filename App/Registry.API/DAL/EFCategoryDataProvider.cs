using System.Collections.Generic;
using System.Data.Entity;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using Registry.Common.DTO;

namespace Registry.API.DAL
{
    public class EFCategoryDataProvider : EFDataProviderBase, ICategoryDataProvider
    {
        public async Task<IEnumerable<EventCategorySelect>> GetEventCategories(GetEventCategoryRequest getEventCategoryRequest)
        {
            using (var context = RegistryDb)
            {
                return await ExecuteStoredProcedure<EventCategorySelect, GetEventCategoryRequest>("GetEventCategory", getEventCategoryRequest, context);
            }
        }

        public async Task<EventCategoryInsertUpdate> GetEventCategory(int eventCategoryId)
        {
            using (var context = RegistryDb)
            {
                var result = await ExecuteStoredProcedure<EventCategoryInsertUpdate, GetEventCategoryRequest>(
                    "GetEventCategory", new GetEventCategoryRequest { EventCategoryID = eventCategoryId }, context
                );

                return result.SingleOrDefault();
            }
        }

        public async Task<int> InsertEventCategory(EventCategoryInsertUpdate eventCategory)
        {
            using (var context = RegistryDb)
            {
                var result = await ExecuteStoredProcedure<EventCategoryInsertUpdate, EventCategoryInsertUpdate>("InsertEventCategory", eventCategory, context);

                return result.Single().EventCategoryID.Value;
            }
        }

        public async Task<int> UpdateEventCategory(EventCategoryInsertUpdate eventCategory)
        {
            using (var context = RegistryDb)
            {
                return await ExecuteStoredProcedure("UpdateEventCategory", eventCategory, context);
            }
        }

        public async Task<IEnumerable<EventSubCategorySelect>> GetEventSubCategories(GetEventSubCategoryRequest getEventSubCategoryRequest)
        {
            using (var context = RegistryDb)
            {
                return await ExecuteStoredProcedure<EventSubCategorySelect, GetEventSubCategoryRequest>("GetEventSubCategory", getEventSubCategoryRequest, context);
            }
        }

        public async Task<EventSubCategoryInsertUpdate> GetEventSubCategory(int eventSubCategoryId)
        {
            using (var context = RegistryDb)
            {
                var result = await ExecuteStoredProcedure<EventSubCategoryInsertUpdate, GetEventSubCategoryRequest>(
                    "GetEventSubCategory", new GetEventSubCategoryRequest { EventSubCategoryID = eventSubCategoryId }, context
                );

                return result.SingleOrDefault();
            }
        }

        public async Task<int> InsertEventSubCategory(EventSubCategoryInsertUpdate eventSubCategory)
        {
            using (var context = RegistryDb)
            {
                var result = await ExecuteStoredProcedure<EventSubCategoryInsertUpdate, EventSubCategoryInsertUpdate>("InsertEventSubCategory", eventSubCategory, context);

                return result.Single().EventSubCategoryID.Value;
            }
        }

        public async Task<int> UpdateEventSubCategory(EventSubCategoryInsertUpdate eventSubCategory)
        {
            using (var context = RegistryDb)
            {
                return await ExecuteStoredProcedure("UpdateEventSubCategory", eventSubCategory, context);
            }
        }

        public async Task SaveCategories(EditCategorySaveModel categories)
        {
            foreach (var category in categories.Categories)
            {
                var categoryModel = new EventCategoryInsertUpdate
                {
                    EventCategoryActive = category.Active,
                    EventCategoryName = category.Name,
                    EventCategorySpecifyText = category.SpecifyText,
                    RegistryOwnerID = categories.RegistryOwnerId
                };

                int categoryId;

                if (category.Id > 0)
                {
                    categoryModel.EventCategoryID = category.Id;
                    categoryId = category.Id;
                    await UpdateEventCategory(categoryModel);
                }
                else
                {
                    categoryId = await InsertEventCategory(categoryModel);
                }

                foreach (var subcategory in category.Subcategories)
                {
                    var subcategoryModel = new EventSubCategoryInsertUpdate
                    {
                        EventCategoryID = categoryId,
                        EventSubCategoryActive = subcategory.Active,
                        EventSubCategorySpecifyText = subcategory.SpecifyText,
                        EventSubCategoryName = subcategory.Name,
                        EventSubCategorySourceCode = subcategory.SourceCode
                    };

                    if (subcategory.Id > 0)
                    {
                        subcategoryModel.EventSubCategoryID = subcategory.Id;
                        await UpdateEventSubCategory(subcategoryModel);
                    }
                    else
                    {
                        await InsertEventSubCategory(subcategoryModel);
                    }
                }
            }
        }
    }
}
