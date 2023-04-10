using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Registry.API.DAL.Databases.Registry.Entities
{
    [Table("RegistryOwnerStateConfig")]
    public class RegistryOwnerStateConfig
    {
        [Key]
        public int RegistryOwnerStateConfigID { get; set; }

        public int RegistryOwnerID { get; set; }

        [StringLength(2)]
        public string RegistryOwnerStateAbbrv { get; set; }

        public bool DisableDMVSearchOption { get; set; }

        [ForeignKey("RegistryOwnerID")]
        public RegistryOwner RegistryOwner { get; set; }
    }
}
