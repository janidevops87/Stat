namespace Registry.Common.DTO
{
    public class EditSubCategoryModel : EditCategoryModel
    {
        public int ParentId { get; set; } //not sure if we need this
        public string SourceCode { get; set; }
    }
}
