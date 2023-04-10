using System.Collections.Generic;

namespace Registry.Common.DTO
{
    public class RegistryEventCategory
    {
        public int EventCategoryID { get; set; }
        public string EventCategoryName { get; set; }
        public bool EventCategorySpecifyText { get; set; }
        public bool EventCategoryActive { get; set; }
        public IEnumerable<RegistryEventSubCategory> SubCategories { get; set; }
    }
}
