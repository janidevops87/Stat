using System.Data.Entity;

namespace Registry.API.DAL.Databases
{
    public class DbContextBase : DbContext
    {
        public DbContextBase(string name) : base(name)
        {
            //we are working with legacy DB, no need to validate schema and so on
            Configuration.LazyLoadingEnabled = false;
            Configuration.AutoDetectChangesEnabled = false;
        }
    }
}