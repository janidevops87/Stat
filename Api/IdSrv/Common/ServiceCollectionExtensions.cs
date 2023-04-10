using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Statline.Common.Infrastructure.Configuration.Database;
using Statline.Common.Infrastructure.Services;
using Statline.Common.Services;
using Statline.Common.Utilities;
using Statline.IdentityServer.Common.AdministrativeTenant;
using Statline.IdentityServer.Common.TenantIdAccessor;
using Statline.IdentityServer.IdentityAndAccess.App.Bootstrap;
using Statline.IdentityServer.IdentityAndAccess.App.Common;
using Statline.IdentityServer.IdentityAndAccess.App.Roles;
using Statline.IdentityServer.IdentityAndAccess.App.Tenants;
using Statline.IdentityServer.IdentityAndAccess.App.Users;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Command;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Query;
using Statline.IdentityServer.IdentityAndAccess.Infrastructure.Notification;
using Statline.IdentityServer.IdentityAndAccess.Infrastructure.Persistence.Ef;
using Statline.IdentityServer.IdentityServerConfig.App.Clients;
using Statline.IdentityServer.IdentityServerConfig.App.Resources.Api;
using Statline.IdentityServer.IdentityServerConfig.App.Resources.Identity;
using Statline.IdentityServer.IdentityServerConfig.Domain.Model;
using Statline.IdentityServer.IdentityServerConfig.Infrastructure.Persistence.Ef;
using Statline.Statrac.IdentityServerIntegration;

namespace Statline.IdentityServer.Common
{
    public static class ServiceCollectionExtensions
    {
        public static void AddConfigurationEditingApplication(
            this IServiceCollection services,
            Action<MultiTenantConfigurationStoreOptions> storeOptionsAction)
        {
            // All this dancing is needed because tenant id 
            // accessor gets tenant id from user claims
            // which are in the HttpContext. However,
            // context is not present when running via 
            // tool like EF migrations, so need a fall-back way.
            services.AddDecoratorSingleton<
                ITenantIdAccessor,
                WithDesignTimeFallbackTenantIdAccessor>(
                s =>
                {
                    // The order of adding accessors matters!
                    s.AddSingleton<ITenantIdAccessor, HttpContextTenantIdAccessor>();
                    s.AddSingleton<ITenantIdAccessor, DesignTimeTenantIdAccessor>();
                    s.AddSingleton<IDesignTimeDetector, DesignTimeDetector>();
                });

            services.AddDecoratorSingleton<
                IAdministrativeTenantIdProvider,
                WithDesignTimeFallbackAdministrativeTenantIdProvider>(
                s =>
                {
                    s.AddSingleton<IAdministrativeTenantIdProvider, AdministrativeTenantIdProvider>();
                    s.AddSingleton<IDesignTimeDetector, DesignTimeDetector>();
                });
                        
            services.AddMultiTenantConfigurationDbContext(storeOptionsAction);

            services.AddTransient<IClientRepository, EfClientRepository>();
            services.AddTransient<IApiResourceRepository, EfApiResourceRepository>();
            services.AddTransient<IIdentityResourceRepository, EfIdentityResourceRepository>();

            services.AddScoped<ClientApplication>();
            services.AddScoped<ApiResourceApplication>();
            services.AddScoped<IdentityResourceApplication>();

            services.AddSingleton<IDateTimeService, DateTimeService>();
        }

        public static void ConfigureIdentityServerConfigurationDbContext(
            this DbContextOptionsBuilder optionsBuilder,
            IConfiguration config,
            string settingsPath)
        {
            var migrationsAssembly = typeof(EfClientRepository).Assembly.GetName().Name;
            optionsBuilder.ConfigureDbContext(config, settingsPath, migrationsAssembly);
        }

        public static void ConfigureIdentityServerOperationalDbContext(
            this DbContextOptionsBuilder optionsBuilder,
            IConfiguration config,
            string settingsPath)
        {
            var migrationsAssembly = typeof(Startup).Assembly.GetName().Name;
            optionsBuilder.ConfigureDbContext(config, settingsPath, migrationsAssembly);
        }

        public static void ConfigureDbContext(
           this DbContextOptionsBuilder optionsBuilder,
           IConfiguration config,
           string settingsPath,
           string migrationsAssemblyName = null)
        {
            Check.NotNull(optionsBuilder, nameof(optionsBuilder));
            Check.NotNull(config, nameof(config));

            var databaseSettings =
                config.GetSqlDatabaseSettings(settingsPath);

            optionsBuilder
                .EnableSensitiveDataLogging(databaseSettings.EnableSensitiveDataLogging)
                .UseSqlServer(
                    databaseSettings.ConnectionString,
                    sqloptions =>
                    {
                        sqloptions.MigrationsAssembly(migrationsAssemblyName);
                        sqloptions.EnableRetryOnFailure();
                    });
        }

        public static void AddStatracIdentityServerIntegration(
            this IServiceCollection services,
            IConfiguration config)
        {
            services.AddStatracIdentityServerIntegration(
                config,
                "StatTracIntegration:ConfigurationDb");
        }

        public static void AddUserManagementApplicationAndServices(
            this IServiceCollection services,
            IConfiguration config)
        {
            Check.NotNull(services, nameof(services));
            Check.NotNull(config, nameof(config));

            var appConfig = config.GetSection("IdentityAndAccess");

            services.AddUserManagementApplication(appConfig);

            services.AddScoped<IUserRepository, EfUserRepository>();
            services.AddScoped<IQueryUserRepository, EfQueryUserRepository>();

            services.ConfigureEmailSenderSettingsOptions(config,
                "IdentityAndAccess:UserManagementOptions:UserActivatedNotification");

            services.AddSingleton<INotificationService, SmtpNotificationService>();
        }

        public static void AddUserQueryApplicationAndServices(
           this IServiceCollection services)
        {
            Check.NotNull(services, nameof(services));

            services.AddUserQueryApplication();

            services.AddScoped<IQueryUserRepository, EfQueryUserRepository>();
        }

        public static void AddRoleManagementApplicationAndServices(
          this IServiceCollection services)
        {
            Check.NotNull(services, nameof(services));

            services.AddScoped<RoleManagementApplication>();

            services.AddScoped<IRoleRepository, EfRoleRepository>();
        }

        public static void AddTenantManagementApplicationAndServices(
           this IServiceCollection services)
        {
            Check.NotNull(services, nameof(services));

            services.AddScoped<TenantManagementApplication>();

            services.AddScoped<ITenantRepository, EfTenantRepository>();
        }

        public static void AddBootstrapApplication(
            this IServiceCollection services,
            IConfiguration config)
        {
            var appConfig = config.GetSection("ApplicationBootstrap");

            services.Configure<BootstrapApplicationOptions>(appConfig)
                    // Some options are taken from different parts
                    // of app config to avoid duplication.
                    .Configure<BootstrapApplicationOptions>(o =>
                    {
                        o.AdministrativeTenantOrganizationName =
                           config.GetValue<string>(
                               "IdentityServer:AdministrativeTenantOrganizationName");

                        o.DefaultAdminUserName =
                           config.GetValue<string>(
                               "IdentityServer:DefaultAdmin:UserName");
                    });
            services.AddScoped<BootstrapApplication>();
        }
    }
}
