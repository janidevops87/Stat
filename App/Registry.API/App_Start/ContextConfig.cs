using System.Data.Entity;
using Registry.API.DAL.Databases.Referral;
using Registry.API.DAL.Databases.Registry;

namespace Registry.API
{
    public static class ContextConfig
    {
        public static void Register()
        {
            //By default Entity Framework performs some operations against the database in behind
            //For example, it tracks model changes and will raise error if the model does not correspond to the DB schema
            //we don't need anything of those, we are using EF only for DB queries
            //those lines make our contexts inert, they will not check the schema, create migration tables and other stuff
            Database.SetInitializer<ReferralContext>(null);
            Database.SetInitializer<RegistryContext>(null);
        }
    }
}