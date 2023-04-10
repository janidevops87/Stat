using System.Threading;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using Statline.Common.Domain.Events;
using Statline.Common.Infrastructure.Domain.Events;
using Statline.Common.Utilities;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Command;

namespace Statline.IdentityServer.IdentityAndAccess.Infrastructure.Persistence.Ef
{
    public class IdentityAndAccessDbContext : IdentityDbContext<User, Role, string>
    {
        private readonly IDomainEventPublisher domainEventPublisher;

        public DbSet<Tenant> Tenants { get; set; }

        public IdentityAndAccessDbContext(
            DbContextOptions<IdentityAndAccessDbContext> options,
            IDomainEventPublisher domainEventPublisher)
            : base(options)
        {
            Check.NotNull(domainEventPublisher, nameof(domainEventPublisher));
            this.domainEventPublisher = domainEventPublisher;
        }

        protected override void OnModelCreating(ModelBuilder builder)
        {
            base.OnModelCreating(builder);

            builder.Entity<User>(b =>
            {
                b.Ignore(u => u.DomainEvents);

                b.HasOne<Tenant>()
                    .WithMany()
                    .HasForeignKey(u => u.TenantId)
                    .OnDelete(DeleteBehavior.Cascade);

                b.ToTable("Users");
            });

            builder.Entity<Tenant>(b =>
            {
                b.Ignore(t => t.DomainEvents);

                b.Property(t => t.OrganizationName)
                    .IsRequired()
                    .HasMaxLength(256); // Index requires the column to be no bigger than 900 bytes, so put some limit.

                // TODO: Check if there is cleaner way to do this.
                var navigation = 
                    b.Metadata.FindNavigation(nameof(Tenant.UserClaims));

                navigation.SetPropertyAccessMode(PropertyAccessMode.Field);

                b.HasMany(t => t.UserClaims).WithOne().IsRequired();

                b.HasIndex(t => t.OrganizationName).HasName("OrganizationNameIndex").IsUnique();
            });

            builder.Entity<Claim>(b =>
            {
                // Defining primary key as shadow property since
                // Claim class doesn't have one 
                // (and shouldn't, being a DDD Value Object).
                b.Property<int>("Id");
                b.HasKey("Id");

                b.Property(c => c.Type).IsRequired();
                b.Property(c => c.Value).IsRequired();

                b.ToTable("TenantClaims");
            });


            builder.Entity<Role>().ToTable("Roles");
            builder.Entity<IdentityRoleClaim<string>>().ToTable("RoleClaims");

            builder.Entity<IdentityUserRole<string>>().ToTable("UserRoles");
            builder.Entity<IdentityUserLogin<string>>().ToTable("UserLogins");
            builder.Entity<IdentityUserToken<string>>().ToTable("UserTokens");
            builder.Entity<IdentityUserClaim<string>>().ToTable("UserClaim");
        }

        public override async Task<int> SaveChangesAsync(CancellationToken cancellationToken = default(CancellationToken))
        {
            var result = await base.SaveChangesAsync(cancellationToken);

            // Dispatch Domain Events collection. 
            // Choices:
            // A) Right BEFORE committing data (EF SaveChanges) into the DB 
            // will make a single transaction including  
            // side effects from the domain event handlers which 
            // are using the same DbContext with "InstancePerLifetimeScope" 
            // or "scoped" lifetime;
            // B) Right AFTER committing data (EF SaveChanges) into the DB 
            // will make multiple transactions. Will need to handle eventual 
            // consistency and compensatory actions in case of failures 
            // in any of the Handlers. 
            await domainEventPublisher.DispatchDomainEventsAsync(this);

            return result;
        }
    }
}
