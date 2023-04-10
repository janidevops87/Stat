using System.Collections.Generic;

namespace Registry.Common.DTO
{
    public class EditCategorySaveModel
    {
        public int RegistryOwnerId { get; set; }
        public IEnumerable<EditCategoryModel> Categories { get; set; }
    }
}
