using System.Data.Entity.Migrations;

namespace Registry.API.DAL.Databases.Registry
{
    internal sealed class Configuration : DbMigrationsConfiguration<RegistryContext>
    {
        public Configuration()
        {
            AutomaticMigrationsEnabled = false;
        }
    }
}