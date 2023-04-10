using AutoMapper;
using AutoMapper.EquivalencyExpression;
using IdentityServer4.Configuration;
using IdentityServer4.EntityFramework.Options;
using MediatR;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Authorization;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Statline.Common.Domain.Events;
using Statline.Common.Infrastructure.Domain.Events;
using Statline.IdentityServer.Common;
using Statline.IdentityServer.Common.FeatureFolders;
using Statline.IdentityServer.Common.Security;
using Statline.IdentityServer.Features.IdentityServerOperation.Account;
using Statline.IdentityServer.IdentityAndAccess.App.Common;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Command;
using Statline.IdentityServer.IdentityAndAccess.Infrastructure.Persistence.Ef;
using System.Security.Cryptography.X509Certificates;

namespace Statline.IdentityServer
{

    public class Startup
    {
        private IConfiguration Configuration { get; }
        public IHostEnvironment Environment { get; }

        public Startup(
            IConfiguration configuration,
            IHostEnvironment env)
        {
            Configuration = configuration;
            Environment = env;
        }

        public void ConfigureServices(IServiceCollection services)
        {
            ConfigureCommonServices(services);
            ConfigureWebApp(services);
            ConfigureApplicationServices(services);
        }

        private void ConfigureWebApp(IServiceCollection services)
        {
            // TODO: Move to some extension method.
            services.AddScoped<IUserClaimsPrincipalFactory<User>, UserClaimsPrincipalFactory>();
            services.Configure<DefaultAdminOptions>(
                Configuration.GetSection("IdentityServer:DefaultAdmin"));

            services.AddAuthentication()
                    .AddMicrosoftAccount(o =>
                    {
                        o.SignInScheme = "Identity.External";
                        o.ClientId = Configuration["AppSettings:MicrosoftClientId"];
                        o.ClientSecret = Configuration["AppSettings:MicrosoftClientSecret"];
                    })
                    .AddGoogle(o =>
                    {
                        o.SignInScheme = "Identity.External";
                        o.ClientId = Configuration["AppSettings:GoogleClientId"];
                        o.ClientSecret = Configuration["AppSettings:GoogleClientSecret"];
                    });

            services.AddControllersWithViews(o =>
            {
                // Globally require authenticated user. 
                // Might be redundant, but just to be sure.
                o.Filters.Add(new AuthorizeFilter(
                    AuthorizationPolicies.AuthenticatedUserPolicy));

                o.Filters.Add(new Helper.SecurityHeadersAttribute());

                if (!Environment.IsDevelopment())
                {
                    o.Filters.Add(new RequireHttpsAttribute());
                }

                o.Conventions.Add(new FeatureConvention());
            })
            .AddRazorOptions(options =>
            {
                options.ConfigureFeatureFolders();
                // options.ConfigureFeatureFoldersSideBySideWithStandardViews();
            });

            services.AddAuthorization(options =>
            {
                options.AddPolicy(AuthorizationPolicies.AuthenticatedUserPolicy,
                    policy => policy.RequireAuthenticatedUser());

                options.AddPolicy(AuthorizationPolicies.WholeApplicationAdministrationPolicy,
                    policy => policy.RequireRole(
                        WellKnownRoles.StatlineAdmin));

                options.AddPolicy(AuthorizationPolicies.ConfigurationViewingPolicy,
                    policy => policy.RequireRole(
                        WellKnownRoles.CustomerAdmin,
                        WellKnownRoles.StatlineAdmin));

                options.AddPolicy(AuthorizationPolicies.ConfigurationEditingPolicy,
                    policy => policy.RequireRole(
                        WellKnownRoles.CustomerAdmin,
                        WellKnownRoles.StatlineAdmin));
            });

            services.AddIdentityServer(o =>
            {
                o.UserInteraction.ErrorUrl = "/Account/Error";

                // Some apps like DonorTrac API are using old authorization
                // libraries which have problems with some modern behavior of
                // IdentityServer (https://github.com/IdentityServer/IdentityServer4/issues/3705).
                // These settings preserve compatibility with earlier IdentityServer versions.
                o.AccessTokenJwtType = "JWT";
                o.EmitLegacyResourceAudienceClaim = true;
            })
            .AddSigningCredential(
                // TODO: Refactor certificates configuration 
                // to be able to reference it from a dedicated config section.
                name: Configuration.GetValue<string>("IdentityServer:SigningCredential:Certificate:Thumbprint"),
                location: Configuration.GetValue<StoreLocation>("IdentityServer:SigningCredential:Certificate:StoreLocation"),
                nameType: NameType.Thumbprint)
            // this adds the operational data from DB (codes, tokens, consents)
            .AddOperationalStore(OperationalStoreOptionsConfigurator)
            // this adds the config data from DB (clients, resources, CORS)
            // For IdentityServer itself we don't use 
            // MultiTenantConfigurationDbContext since we don't 
            // need filtering by tenant here. 
            .AddConfigurationStore(ConfigStoreOptionsConfigurator)
            .AddAspNetIdentity<User>()
            .AddCustomAuthorizeRequestValidator<TenantMatchAuthorizeRequestValidator>();

            // TODO: This definitely needs to be better tweaked:
            // https://identityserver4.readthedocs.io/en/latest/topics/cors.html
            services.AddSingleton<IdentityServer4.Services.ICorsPolicyService>(sp =>
            {
                var logger = sp.GetRequiredService<ILogger<IdentityServer4.Services.DefaultCorsPolicyService>>();

                return new IdentityServer4.Services.DefaultCorsPolicyService(logger)
                {
                    AllowAll = true
                };
            });

        }

        public void ConfigureCommonServices(IServiceCollection services)
        {
            services.AddIdentity<User, Role>()
               .AddEntityFrameworkStores<IdentityAndAccessDbContext>()
               .AddDefaultTokenProviders();

          
            // TODO: Specify assemblies containing handlers.
            services.AddMediatR();

            services.AddScoped<
                IDomainEventPublisher,
                MediatrDomainEventPublisher>();

            services.AddAutoMapper(cfg => cfg.AddCollectionMappers(),
                typeof(Startup),
                typeof(IdentityAndAccess.App.Users.Dto.UserMappingProfile),
                typeof(IdentityServerConfig.App.Clients.Dto.ClientMappingProfile));
        }

        public void ConfigureApplicationServices(IServiceCollection services)
        {
            services.AddDbContext<IdentityAndAccessDbContext>(options =>
            {
                options.ConfigureDbContext(Configuration, "IdentityAndAccess:StorageDb");
            });

            services.AddStatracIdentityServerIntegration(Configuration);
            services.AddUserManagementApplicationAndServices(Configuration);
            services.AddUserQueryApplicationAndServices();
            services.AddRoleManagementApplicationAndServices();
            services.AddTenantManagementApplicationAndServices();
            services.AddBootstrapApplication(Configuration);
            services.AddConfigurationEditingApplication(ConfigStoreOptionsConfigurator);
        }

        private void ConfigStoreOptionsConfigurator(ConfigurationStoreOptions options)
        {
            options.ConfigureDbContext = builder =>
                 builder.ConfigureIdentityServerConfigurationDbContext(
                     Configuration,
                     "IdentityServer:ConfigurationStoreDb");
        }

        private void OperationalStoreOptionsConfigurator(OperationalStoreOptions options)
        {
            options.ConfigureDbContext = builder =>
                builder.ConfigureIdentityServerOperationalDbContext(
                    Configuration,
                    "IdentityServer:OperationalStoreDb");

            // Indicates whether stale entries will be automatically 
            // cleaned up from the database.
            options.EnableTokenCleanup = true;
        }

        public void Configure(
            IApplicationBuilder app,
            IHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                app.UseExceptionHandler("/Home/Error");
                app.UseHsts();
            }

            app.UseHttpsRedirection();

            app.UseStaticFiles();

            app.UseRouting();

            app.UseCors();

            // UseIdentityServer includes a call to UseAuthentication,
            // so it’s not necessary to have both.
            app.UseIdentityServer();
            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllerRoute("default", "{controller=Home}/{action=Index}/{id?}");
            });
        }
    }
}
