using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Statline.StatTrac.Domain.SourceCodes;

#nullable enable

namespace Statline.StatTrac.Infrastructure.Persistence.Ef.SourceCodes;

internal class EntityConfiguration :
    IEntityTypeConfiguration<SourceCode>
{
    public void Configure(EntityTypeBuilder<SourceCode> builder)
    {
    }
}
