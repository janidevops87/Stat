using System.Data.Entity;
using Registry.API.DAL.Databases.Registry.Entities;

namespace Registry.API.DAL.Databases.Registry
{
    public class RegistryContext: DbContextBase
    {
        public RegistryContext(string name) : base(name)
        {
        }

        public virtual IDbSet<RegistryOwner> RegistryOwner { get; set; }
        public virtual IDbSet<RegistryOwnerUserOrg> RegistryOwnerUserOrg { get; set; }
        public virtual IDbSet<EventCategory> EventCategory { get; set; }
        public virtual IDbSet<EventSubCategory> EventSubCategory { get; set; }
    }
}