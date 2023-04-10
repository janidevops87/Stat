using Microsoft.EntityFrameworkCore;
using Statline.StatTracUploader.Domain.Temporary;

namespace Statline.StatTracUploader.Infrastructure.Persistence.Ef
{
    public class ReferralDbContext<TDbContext> : DbContext
        where TDbContext : ReferralDbContext<TDbContext>
    {
        public ReferralDbContext(DbContextOptions<TDbContext> options)
            : base(options)
        { }

        public DbSet<ReferralUpload> ReferralUploads => Set<ReferralUpload>();

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            // NOTE: As follows from many levels of nesting of owned types
            // all data model here looks like one big aggregate.
            // For a document-oriented DB (e.g. Cosmos) this looks like
            // single document. For a relational DB (SQL Server) this looks
            // like one big completely denormalized  table.
            // This is intentional in this case, as object model hierarchical
            // structure is for convenience only. We don't really try to recognize
            // separate entities (e.g. Referral, Donor, Employee etc.),
            // give them identities, query them independently etc. The only
            // entity here is ReferralUpload, representing all information
            // gathered during phone call as single piece.

            modelBuilder.Entity<ReferralUpload>(ruBuilder =>
            {
                ruBuilder.Property(ru => ru.AddedToSystemOn);
                ruBuilder.Property(ru => ru.SourceFileName);

                ruBuilder.OwnsOne(ru => ru.Referral, b =>
                {
                    b.OwnsOne(r => r.CallerInformation, ownedBuilder =>
                    {
                        ownedBuilder.OwnsOne(ci => ci.CallerName);
                        ownedBuilder.OwnsOne(ci => ci.PhoneNumber);
                        ownedBuilder.OwnsOne(ci => ci.Extension);
                        ownedBuilder.Property(ci => ci.Unit);
                        ownedBuilder.Property(ci => ci.Floor);
                        ownedBuilder.Property(ci => ci.HospitalName);
                    });

                    b.OwnsOne(r => r.DonorPerson, ownedBuilder =>
                    {
                        ownedBuilder.OwnsOne(dp => dp.Name);
                        ownedBuilder.OwnsOne(dp => dp.Age);
                        ownedBuilder.OwnsOne(dp => dp.Weight);
                        ownedBuilder.Property(dp => dp.DateOfBirth);
                        ownedBuilder.Property(dp => dp.Race);
                        ownedBuilder.Property(dp => dp.Gender);
                        ownedBuilder.Property(dp => dp.MedicalRecordNumber);
                    });

                    b.OwnsOne(r => r.CoordinatorName);

                    b.OwnsOne(r => r.PagingInformation, ownedBuilder =>
                    {
                        ownedBuilder.Property(pi => pi!.PagedToClient);
                        ownedBuilder.Property(pi => pi!.PagedToClientOn);
                        ownedBuilder.Property(pi => pi!.RePagedToClientOn);
                        ownedBuilder.Property(pi => pi!.ReceivedBy);
                        ownedBuilder.Property(pi => pi!.PagedBy);
                        ownedBuilder.Property(pi => pi!.ReferralPagedToHospital);
                    });
                });

                ruBuilder.OwnsOne(ru => ru.ProcessingStatus, ownedBuilder =>
                {
                    ownedBuilder.Property(ci => ci.Status);
                    ownedBuilder.Property(ci => ci.ErrorMessage);
                });
            });
        }
    }
}
