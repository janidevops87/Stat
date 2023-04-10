using IdentityServer4.EntityFramework.Entities;
using Microsoft.EntityFrameworkCore;
using Statline.Common.Utilities;
using Statline.IdentityServer.IdentityServerConfig.Domain.Model;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using IdentityServerDbContexts = IdentityServer4.EntityFramework.DbContexts;

namespace Statline.IdentityServer.IdentityServerConfig.Infrastructure.Persistence.Ef
{
    public class MultiTenantConfigurationDbContext :
        IdentityServerDbContexts.ConfigurationDbContext<MultiTenantConfigurationDbContext>
    {
        private const string TenantIdProperty = "TenantId";

        public int AdministrativeTenantId { get; }
        public int TenantId { get; }

        public MultiTenantConfigurationDbContext(
            DbContextOptions<MultiTenantConfigurationDbContext> options,
            MultiTenantConfigurationStoreOptions storeOptions,
            IAdministrativeTenantIdProvider administrativeTenantIdProvider,
            ITenantIdAccessor tenantIdAccessor)
            : base(options, storeOptions)
        {
            Check.NotNull(tenantIdAccessor, nameof(tenantIdAccessor));
            Check.NotNull(administrativeTenantIdProvider, nameof(administrativeTenantIdProvider));

            TenantId = tenantIdAccessor.GetTenantId().Value;
            AdministrativeTenantId = administrativeTenantIdProvider.GetAdministrativeTenantId();
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // Since we don't have access to the source code of the Client 
            // class, to extend it with Tenant Id property we have to use
            // EF shadow property. This allows using it in global filter
            // and queries, but its not visible to the outer code. To fix
            // this, we also store Tenant Id in Client.Properties collection.
            // Note that we cant use Properties as a sole storage for Tenant Id,
            // since Client.Properties, being a navigation property,
            // can't be used in global filters.
            //
            // TODO: Another approach could be deriving from Client class and
            // adding Tenant Id property to the derivative. However, this would
            // probably complicate the model and not sure how it would work
            // with the Identity Server Configuration Store code. Anyway,
            // consider trying this approach later.
            modelBuilder.Entity<Client>().Property<int>(TenantIdProperty);
            modelBuilder.Entity<ClientSecretExtended>(b =>
            {
                b.HasBaseType<ClientSecret>();
            });

            AddTenantIdGlobalFilter(modelBuilder);
        }

        private void AddTenantIdGlobalFilter(ModelBuilder modelBuilder)
        {
            // This is a global filter by Tenant Id.
            modelBuilder.Entity<Client>().HasQueryFilter(c =>
                // No filtering for administrative tenant.
                // NOTE: Though this condition doesn't check 
                // DB values, we need it in the filter to be evaluated
                // for each DbContext instance. In contrast,
                // the model (with filter) is built only once and
                // then is cached, so we cant put this check around
                // this filter addition.
                TenantId == AdministrativeTenantId ||
                EF.Property<int>(c, TenantIdProperty) == TenantId);
        }

        public override int SaveChanges()
        {
            OnSavingChanges();
            return base.SaveChanges();
        }

        public override async Task<int> SaveChangesAsync(CancellationToken cancellationToken = default)
        {
            OnSavingChanges();
            return await base.SaveChangesAsync(cancellationToken);
        }

        private void OnSavingChanges()
        {
            ChangeTracker.DetectChanges();

            SetTenantIdForAddedClients();
        }

        private void SetTenantIdForAddedClients()
        {
            var addedClientEntries = ChangeTracker
                            .Entries<Client>()
                            .Where(e => e.State == EntityState.Added);

            foreach (var entry in addedClientEntries)
            {
                // This value is for global filter.
                entry.CurrentValues[TenantIdProperty] =
                    // And this one is for outer code 
                    // (e.g. showing tenant id to user).
                    entry.Entity.GetTenantId().Value;
            }

            // TODO: Consider also checking on Updated 
            // entities that Tenant Id in Properties match
            // (hasn't been changed) to the TenantId shadow property.
            // TODO: Consider checking on Added and Deleted entities that
            // current tenant is administrative (in addition 
            // to application authorization checks).
        }
    }
}
