using System.Collections.Generic;

namespace Registry.Common.DTO
{
    public class EditCategoryModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public bool Active { get; set; }
        public bool SpecifyText { get; set; }
        public IEnumerable<EditSubCategoryModel> Subcategories { get; set; }
    }
}
