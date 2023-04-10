using System.ComponentModel.DataAnnotations;

namespace Registry.Common.DTO
{
    public class EventCategoryInsertUpdate
    {
        public int? EventCategoryID { get; set; }
        public int RegistryOwnerID { get; set; }
        [Required]
        [StringLength(255)]
        public string EventCategoryName { get; set; }
        public bool EventCategoryActive { get; set; }
        public bool EventCategorySpecifyText { get; set; }
    }
}
