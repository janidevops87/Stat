using Microsoft.EntityFrameworkCore;

namespace Emailer.LegacyBridge.Infrastructure.EmailMessageQueue.LegacyQueue
{
    internal class ReferralDbContext : DbContext
    {
        public ReferralDbContext(DbContextOptions<ReferralDbContext> options)
            : base(options)
        { }

        public DbSet<AlphaPage> AlphaPage => Set<AlphaPage>();

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<AlphaPage>().ToTable(nameof(AlphaPage));
        }
    }
}
