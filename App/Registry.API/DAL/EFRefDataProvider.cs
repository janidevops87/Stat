using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;
using Registry.Common.DTO;

namespace Registry.API.DAL
{
    public class EFRefDataProvider : EFDataProviderBase, IRefDataProvider
    {
        public async Task<IEnumerable<string>> GetClientStates(GetClientStateRequest getClientStateRequest)
        {
            using (var context = RegistryDb)
            {
                return (await ExecuteStoredProcedure<RegistryOwnerStateConfig, GetClientStateRequest>("GetRegistryOwnerStateConfig", getClientStateRequest, context)).Select(x => x.RegistryOwnerStateAbbrv);
            }
        }

        public async Task<IEnumerable<EditCategoryModel>> GetAllEventCategories(int registryOwnerID)
        {
            using (var context = RegistryDb)
            {
                return await context.EventCategory
                    .Where(x => x.RegistryOwnerID == registryOwnerID)
                    .OrderBy(x => x.EventCategoryName)
                    .Select(x => new EditCategoryModel
                    {
                        Id = x.EventCategoryID,
                        Name = x.EventCategoryName,
                        SpecifyText = x.EventCategorySpecifyText,
                        Active = x.EventCategoryActive,

                        Subcategories = x.EventSubCategories
                        .OrderBy(y => y.EventSubCategoryName)
                        .Select(y => new EditSubCategoryModel
                        {
                            Id = y.EventSubCategoryID,
                            ParentId = y.EventCategoryID,
                            Name = y.EventSubCategoryName,
                            SpecifyText = y.EventSubCategorySpecifyText,
                            Active = y.EventSubCategoryActive,
                            SourceCode = y.EventSubCategorySourceCode
                        })
                    }).ToListAsync();
            }
        }

        public async Task<IEnumerable<RegistryEventCategory>> GetRegistryEventCategories(int registryOwnerID)
        {
            using (var context = RegistryDb)
            {
                return await context.EventCategory
                    .Where(x => x.EventCategoryActive)
                    .Where(x => x.RegistryOwnerID == registryOwnerID)
                    .OrderBy(x => x.EventCategoryName)
                    .Select(x => new RegistryEventCategory
                    {
                        EventCategoryID = x.EventCategoryID,
                        EventCategoryName = x.EventCategoryName,
                        EventCategorySpecifyText = x.EventCategorySpecifyText,

                        SubCategories = x.EventSubCategories
                        .Where(y => y.EventSubCategoryActive)
                        .OrderBy(y => y.EventSubCategoryName)
                        .Select(y => new RegistryEventSubCategory
                        {
                            EventCategoryID = y.EventCategoryID,
                            EventSubCategoryID = y.EventSubCategoryID,
                            EventSubCategoryName = y.EventSubCategoryName,
                            EventSubCategorySpecifyText = y.EventSubCategorySpecifyText
                        })
                    }).ToListAsync();
            }
        }
    }
}
