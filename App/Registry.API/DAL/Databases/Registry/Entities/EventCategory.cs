using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Registry.API.DAL.Databases.Registry.Entities
{
    [Table("EventCategory")]
    public class EventCategory
    {
        public EventCategory()
        {
            EventSubCategories = new HashSet<EventSubCategory>();
        }

        [Key]
        public int EventCategoryID { get; set; }
        [StringLength(255)]
        public string EventCategoryName { get; set; }
        public bool EventCategoryActive { get; set; }
        public bool EventCategorySpecifyText { get; set; }
        public int RegistryOwnerID { get; set; }
        public ICollection<EventSubCategory> EventSubCategories { get; set; }
    }
}
