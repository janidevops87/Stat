using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Statline.StatTrac.Domain.QAProcessor;
using Statline.StatTrac.Infrastructure.Persistence.Ef.Common;

#nullable enable

namespace Statline.StatTrac.Infrastructure.Persistence.Ef.QAProcessor;

internal class EntityConfiguration :
    EntityConfigurationBase,
    IEntityTypeConfiguration<CallTimings>,
    IEntityTypeConfiguration<HighRiskCallReferral>
{
    public void Configure(EntityTypeBuilder<CallTimings> builder)
    {
        builder.HasNoKey();
    }

    public void Configure(EntityTypeBuilder<HighRiskCallReferral> builder)
    {
        builder.HasNoKey();
    }
}
