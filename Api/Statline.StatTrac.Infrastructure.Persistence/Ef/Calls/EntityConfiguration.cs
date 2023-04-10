using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Statline.StatTrac.Domain.Calls;
using Statline.StatTrac.Infrastructure.Persistence.Ef.Common;

namespace Statline.StatTrac.Infrastructure.Persistence.Ef.Calls;

internal class EntityConfiguration :
    EntityConfigurationBase,
    IEntityTypeConfiguration<Call>,
    IEntityTypeConfiguration<CallType>,
    IEntityTypeConfiguration<CallInsertResult>
{
    public void Configure(EntityTypeBuilder<Call> builder)
    {
        builder.ToTable(nameof(Call));
        builder.Property(c => c.CallExtension).HasColumnType("numeric(5, 0)");
        builder.Property(c => c.CallTotalTime).HasConversion<string>();
    }

    public void Configure(EntityTypeBuilder<CallType> builder)
    {
        builder.ToTable(nameof(CallType));
    }

    public void Configure(EntityTypeBuilder<CallInsertResult> builder)
    {
        builder.HasNoKey();
    }
}
