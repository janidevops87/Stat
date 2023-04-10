namespace Registry.Common.DTO
{
    public class GetEventCategoryRequest
    {
        public int? EventCategoryID { get; set; }
        public int? RegistryOwnerID { get; set; }
        public bool? EventCategoryActive { get; set; }
    }
}
