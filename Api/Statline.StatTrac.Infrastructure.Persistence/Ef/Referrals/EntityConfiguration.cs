using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Statline.StatTrac.Domain.Referrals;
using Statline.StatTrac.Domain.Referrals.Factory;
using Statline.StatTrac.Infrastructure.Persistence.Ef.Common;
using System.Globalization;

#nullable enable

namespace Statline.StatTrac.Infrastructure.Persistence.Ef.Referrals;

internal class EntityConfiguration :
    EntityConfigurationBase,
    IEntityTypeConfiguration<Referral>,
    IEntityTypeConfiguration<ReferralWithIdOnly>,
    IEntityTypeConfiguration<ReferralDetails>,
    IEntityTypeConfiguration<ReferralMedication>,
    IEntityTypeConfiguration<ReferralMedicationOther>,
    IEntityTypeConfiguration<ReferralSecondary>,
    IEntityTypeConfiguration<ReferralCriteria>
{
    public void Configure(EntityTypeBuilder<Referral> builder)
    {
        builder.ToTable(nameof(Referral));
        builder.Property(r => r.ReferralExtubated)
            .HasConversion(MountainTimeDateTimeOffsetToStringConverter);

        builder.Property(r => r.ReferralDonorWeight).HasConversion(
            weight => weight!.Value.ToString("0.0", CultureInfo.InvariantCulture),
            str => float.Parse(str, CultureInfo.InvariantCulture));

        builder.Property(r => r.ReferralDonorAge).HasConversion(
            age => age!.Value.ToString(CultureInfo.InvariantCulture),
            str => int.Parse(str, CultureInfo.InvariantCulture));

        builder.Property(r => r.ReferralApproachTypeId).HasConversion<int>();
        builder.Property(r => r.ReferralDobIlb).HasColumnName("ReferralDOB_ILB");
    }

    public void Configure(EntityTypeBuilder<ReferralWithIdOnly> builder)
    {
        builder.HasNoKey();
    }

    public void Configure(EntityTypeBuilder<ReferralDetails> builder)
    {
        builder.HasNoKey();
        // These fields are filled manually from a separate query.
        builder.Ignore(r => r.ReferralLogEvents);
        builder.Ignore(r => r.SecondaryData);
    }

    public void Configure(EntityTypeBuilder<ReferralMedication> builder)
    {
        builder.HasNoKey();
    }

    public void Configure(EntityTypeBuilder<ReferralMedicationOther> builder)
    {
        builder.HasNoKey();
    }

    public void Configure(EntityTypeBuilder<ReferralSecondary> builder)
    {
        builder.HasNoKey();
    }

    public void Configure(EntityTypeBuilder<ReferralCriteria> builder)
    {
        builder.HasNoKey();
    }
}
