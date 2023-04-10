namespace Registry.API.DAL
{
    public class RegistryEventInsertUpdateParameter
    {
        public int? EventRegistryID { get; set; }
        public int? RegistryID { get; set; }
        public int? EventCategoryID { get; set; }
        public int? EventSubCategoryID { get; set; }
        public string EventCategorySpecifyText { get; set; }
        public string EventSubCategorySpecifyText { get; set; }
        public int? LastStatEmployeeID { get; set; }
    }
}
