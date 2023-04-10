using System.Data.Entity.Migrations;

namespace Registry.API.DAL.Databases.Referral
{
    internal sealed class Configuration : DbMigrationsConfiguration<ReferralContext>
    {
        public Configuration()
        {
            AutomaticMigrationsEnabled = false;
        }
    }
}