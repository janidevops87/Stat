using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Statline.StatTrac.Domain.Phones;

namespace Statline.StatTrac.Infrastructure.Persistence.Ef.Phones;

internal class EntityConfiguration :
    IEntityTypeConfiguration<PhoneInsertResult>,
    IEntityTypeConfiguration<Phone>,
    IEntityTypeConfiguration<OrganizationPhone>
{
    public void Configure(EntityTypeBuilder<PhoneInsertResult> builder)
    {
        builder.HasNoKey();
        builder.Property(p => p.PhoneId)
           .HasConversion(
               id => id.Value,
               idValue => new PhoneId(idValue));
    }

    public void Configure(EntityTypeBuilder<Phone> builder)
{
        builder.ToTable(nameof(Phone));
        builder.Property(p => p.PhoneId)
            .HasConversion(
                id => id.Value,
                idValue => new PhoneId(idValue));
    }

    public void Configure(EntityTypeBuilder<OrganizationPhone> builder)
    {
        builder.ToTable(nameof(OrganizationPhone));

        // TODO: Maybe these should be shadow properties assigned automatically
        // by copying from same properties in base class?
        builder.Property(op => op.OrganizationPhoneLastModified).HasColumnName("LastModified");
        builder.Property(op => op.OrganizationPhoneLastStatEmployeeId).HasColumnName("LastStatEmployeeId");
        builder.Property(op => op.OrganizationPhoneAuditLogTypeId).HasColumnName("AuditLogTypeId");
        builder.Property(op => op.OrganizationPhoneInactive).HasColumnName("Inactive");
    }
}
