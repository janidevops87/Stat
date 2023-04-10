using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.HttpsPolicy;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.SpaServices.AngularCli;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Statline.Ereferral.Web.Contexts;
using Statline.Ereferral.Web.Filters;
using Statline.Ereferral.Web.LogProvider;
using Statline.Ereferral.Web.Services;
using System.IdentityModel.Tokens.Jwt;

namespace Statline.Ereferral.Web
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddSession(options =>
            {
                options.Cookie.HttpOnly = true;
                options.Cookie.IsEssential = true;
            });

            services.AddControllersWithViews(config =>
            {
                config.Filters.Add(typeof(LogExceptionFilter));
                config.Filters.Add(typeof(LogActionFilter));
                config.EnableEndpointRouting = false;
            });
            services.Configure<EreferralSettings>(Configuration);
            services.AddSingleton(Configuration);
            services.AddDbContext<TransactionContext>(options => options.UseSqlServer(Configuration.GetConnectionString("Ereferral")));
            services.AddScoped<ITransactionContext, TransactionContext>();
            services.AddScoped<IStattracApi, StatTracApi>();
            services.AddIdentity<EreferralUser, EreferralRole>(options =>
            {
                options.User.RequireUniqueEmail = true;
            })
            .AddEntityFrameworkStores<TransactionContext>()
            .AddDefaultTokenProviders();
            // In production, the Angular files will be served from this directory
            services.AddSpaStaticFiles(configuration =>
            {
                configuration.RootPath = "ClientApp/dist";
            });

        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env, ILoggerFactory loggerFactory)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
                LoggerFactory.Create(builder => { builder.AddConsole(); });

            }
            else
            {
                app.UseExceptionHandler("/Error");
                // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
                app.UseHsts();
            }
            LoggerFactory.Create(builder=>builder.AddProvider(new DatabaseLoggerProvider(Configuration.GetConnectionString("Ereferral"))));
            loggerFactory.AddProvider(new DatabaseLoggerProvider(Configuration.GetConnectionString("Ereferral")));
            JwtSecurityTokenHandler.DefaultInboundClaimTypeMap.Clear();

            app.UseSession();

            app.UseHttpsRedirection();
            app.UseStaticFiles();
            if (!env.IsDevelopment())
            {
                app.UseSpaStaticFiles();
            }

            app.UseRouting();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllerRoute(
                    name: "default",
                    pattern: "{controller}/{action=Index}/{id?}");
            });

            app.UseSpa(spa =>
            {
                // To learn more about options for serving an Angular SPA from ASP.NET Core,
                // see https://go.microsoft.com/fwlink/?linkid=864501

                spa.Options.SourcePath = "ClientApp";

                if (env.IsDevelopment())
                {
                    spa.UseAngularCliServer(npmScript: "start");
                }
            });
        }
    }
}
