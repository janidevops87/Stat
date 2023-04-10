using Microsoft.EntityFrameworkCore;

namespace Statline.Statrac.IdentityServerIntegration.Infrastructure.Persistence.Ef
{
    /// <summary>
    /// NOTE: This is not a fully-fledged DB context. Its used just as a 
    /// bridge between object model and existing SQL database. The entities are
    /// basically DTOs, and the queries are done in raw SQL.
    /// </summary>
    public class ConfigurationDbContext : DbContext
    {
        public ConfigurationDbContext(DbContextOptions<ConfigurationDbContext> options)
            : base(options)
        {
        }

        internal DbSet<Configuration> Configurations { get; set; }
    }
}
