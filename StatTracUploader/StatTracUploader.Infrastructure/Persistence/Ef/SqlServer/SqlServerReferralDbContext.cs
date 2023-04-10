using Microsoft.EntityFrameworkCore;
using Statline.StatTracUploader.Domain.Temporary;

namespace Statline.StatTracUploader.Infrastructure.Persistence.Ef.SqlServer
{
    internal class SqlServerReferralDbContext :
        ReferralDbContext<SqlServerReferralDbContext>
    {
        public SqlServerReferralDbContext(
            DbContextOptions<SqlServerReferralDbContext> options) : base(options)
        {
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<ReferralUpload>(ruBuilder =>
            {
                ruBuilder.OwnsOne(ru => ru.Referral, b =>
                {
                    b.OwnsOne(r => r.CallerInformation, ownedBuilder =>
                    {
                        ownedBuilder.OwnsOne(ci => ci.PhoneNumber, b =>
                        {
                            b.Property(pn => pn.AreaCode).HasColumnType("char(3)");
                            b.Property(pn => pn.Prefix).HasColumnType("char(3)");
                            b.Property(pn => pn.Number).HasColumnType("char(4)");
                        });

                        ownedBuilder.OwnsOne(ci => ci.Extension, extBuilder =>
                        {
                            extBuilder.Property(ext => ext!.Value)
                                .HasColumnType($"varchar({PhoneExtension.MaxNumberOfDigits})");
                        });
                    });

                    b.OwnsOne(r => r.DonorPerson, ownedBuilder =>
                    {
                        ownedBuilder.Property(dp => dp.Gender).HasColumnType("tinyint");
                        ownedBuilder.OwnsOne(dp => dp.Age).Property(age => age!.Unit).HasColumnType("tinyint");
                        ownedBuilder.OwnsOne(dp => dp.Weight).Property(weight => weight!.Unit).HasColumnType("tinyint");
                    });

                    b.OwnsOne(r => r.PagingInformation);

                    b.Property(r => r.Vent).HasColumnType("tinyint");
                });

                ruBuilder.OwnsOne(ru => ru.ProcessingStatus, ownedBuilder =>
                {
                    ownedBuilder.Property(ci => ci.Status).HasColumnType("tinyint");
                });
            });
        }
    }
}
