using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Statline.StatTrac.Domain.Persons;

namespace Statline.StatTrac.Infrastructure.Persistence.Ef.Persons;

internal class EntityConfiguration :
    IEntityTypeConfiguration<Person>,
    IEntityTypeConfiguration<PersonInsertResult>,
    IEntityTypeConfiguration<StatEmployee>
{
    public void Configure(EntityTypeBuilder<Person> builder)
    {
        builder.ToTable(nameof(Person));
        builder.Property(p => p.PersonId)
            .HasConversion(
                id => id.Value,
                idValue => new PersonId(idValue));
    }

    public void Configure(EntityTypeBuilder<PersonInsertResult> builder)
    {
        builder.HasNoKey();
    }

    public void Configure(EntityTypeBuilder<StatEmployee> builder)
    {
        builder.ToTable(nameof(StatEmployee));
        builder.Property(e => e.PersonId)
            .HasConversion(
                id => id!.Value.Value,
                idValue => new PersonId(idValue));
    }
}
