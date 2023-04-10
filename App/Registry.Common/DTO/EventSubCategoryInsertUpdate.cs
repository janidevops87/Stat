using System.ComponentModel.DataAnnotations;

namespace Registry.Common.DTO
{
    public class EventSubCategoryInsertUpdate
    {
        public int? EventSubCategoryID { get; set; }
        public int EventCategoryID { get; set; }
        [Required]
        [StringLength(255)]
        public string EventSubCategoryName { get; set; }
        [StringLength(255)]
        public string EventSubCategorySourceCode { get; set; }
        public bool EventSubCategoryActive { get; set; }
        public bool EventSubCategorySpecifyText { get; set; }
    }
}
