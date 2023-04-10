using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Registry.API.DAL.Databases.Registry.Entities
{
    [Table("EventSubCategory")]
    public class EventSubCategory
    {
        [Key]
        public int EventSubCategoryID { get; set; }
        [StringLength(255)]
        public string EventSubCategoryName { get; set; }
        public bool EventSubCategoryActive { get; set; }
        public bool EventSubCategorySpecifyText { get; set; }
        public string EventSubCategorySourceCode { get; set; }
        public int EventCategoryID { get; set; }
        public EventCategory EventCategory { get; set; }
    }
}
