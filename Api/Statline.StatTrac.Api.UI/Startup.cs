using IdentityModel;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Statline.Common.Infrastructure.Azure.ApplicationIsights;
using Statline.StatTrac.Api.UI.App.Configuration;
using System.IdentityModel.Tokens.Jwt;

namespace Statline.StatTrac.Api.UI
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        public void ConfigureServices(IServiceCollection services)
        {
            services.Configure<AppSettings>(Configuration.GetSection("AppSettings"));

            services.AddAuthentication(options => options.DefaultScheme = "oidc")
                .AddCookie()
                .AddOpenIdConnect(authenticationScheme: "oidc", configureOptions: o =>
                {
                    o.TokenValidationParameters.NameClaimType = JwtClaimTypes.Name;

                    o.SignInScheme = "Cookies";

                    o.Authority = Configuration["AppSettings:StatlineStatTracApiIdentityServerUri"];
                    o.RequireHttpsMetadata = Configuration["AppSettings:ExternalRequireHttpsMetadata"] == "True";

                    o.ClientId = Configuration["AppSettings:ExternalClientId"];
                    o.ClientSecret = Configuration["AppSettings:ExternalClientSecret"];

                    o.ResponseType = "code id_token";
                    o.Scope.Add(Configuration["AppSettings:StatlineStatTracApiIdentityServerApiScope"]);
                    o.Scope.Add("offline_access");

                    o.GetClaimsFromUserInfoEndpoint = Configuration.GetValue<bool>("AppSettings:ExternalGetClaimsFromUserInfoEndpoint");
                    o.SaveTokens = Configuration.GetValue<bool>("AppSettings:ExternalSaveTokens");
                });

            services.AddMvc().SetCompatibilityVersion(CompatibilityVersion.Version_2_1);

            services.AddUserNameTelemetry();
        }

        public void Configure(IApplicationBuilder app, IHostingEnvironment env)
        {
            JwtSecurityTokenHandler.DefaultInboundClaimTypeMap.Clear();
           
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();

            }
            else
            {
                app.UseExceptionHandler("/Home/Error");
                app.UseHsts();
            }

            app.UseAuthentication();
            app.UseHttpsRedirection();
            app.UseStaticFiles();
            app.UseMvcWithDefaultRoute();
        }
    }
}