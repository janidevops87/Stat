namespace Registry.Common.DTO
{
    public class GetEventSubCategoryRequest
    {
        public int? EventSubCategoryID { get; set; }
        public int? EventCategoryID { get; set; }
        public bool? EventSubCategoryActive { get; set; }
    }
}
