namespace Registry.Common.DTO
{
    public class RegistryEventSubCategory
    {
        public int EventSubCategoryID { get; set; }
        public int EventCategoryID { get; set; }
        public string EventSubCategoryName { get; set; }
        public bool EventSubCategorySpecifyText { get; set; }
        public bool EventSubCategoryActive { get; set; }
    }
}
