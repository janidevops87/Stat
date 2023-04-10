using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Registry.API.DAL.Databases.Registry.Entities
{
    [Table("RegistryOwnerUserOrg")]
    public class RegistryOwnerUserOrg
    {
        [Key]
        public int RegistryOwnerUserOrgId { get; set; }
        public int RegistryOwnerId { get; set; }
        public int UserOrgId { get; set; }
        public RegistryOwner RegistryOwner { get; set; }
    }
}
