using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.DependencyInjection.Extensions;
using Microsoft.Extensions.Hosting;
using Microsoft.IdentityModel.Tokens;
using Statline.StatTrac.Api.Common;
using Statline.StatTrac.Api.Common.Security;
using Statline.StatTrac.Api.Swagger;
using Statline.StatTrac.Api.ViewModels.TypeConveters;
using System.Text.Json.Serialization;

namespace Statline.StatTrac.Api;

public class Startup
{
    private IWebHostEnvironment Environment { get; }
    private IConfiguration Configuration { get; }

    public Startup(
        IConfiguration configuration,
        IWebHostEnvironment env)
    {
        Configuration = configuration;
        Environment = env;
    }

    public void ConfigureServices(IServiceCollection services)
    {
        services.AddSwaggerGen(Configuration);

        services
            .AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
            .AddJwtBearer(JwtBearerDefaults.AuthenticationScheme, options =>
            {
                options.Authority = Configuration["Authentication:IdentityServerUri"];

                options.TokenValidationParameters = new TokenValidationParameters
                {
                    // Disabling audience (API Resource Name) validation because
                    // we do scope validation, and the scopes are defined
                    // in API Resources, either dedicated or shared by several resources.
                    // More about this here: https://identityserver4.readthedocs.io/en/latest/topics/resources.html#api-resources
                    ValidateAudience = false
                };
            });


        services.AddAuthorization(options =>
        {
            options.AddReferralProcessorApiPolicies();
            options.AddStatTracApiWithWebReportGroupIdPolicies();
            options.AddStatTracLowLevelApiPolicies();
            options.AddStatTracHighLevelApiPolicies();
        });

        services.TryAddSingleton<IHttpContextAccessor, HttpContextAccessor>();

        services.AddControllers(options =>
            {
                options.SuppressOutputFormatterBuffering = true;
                options.Filters.Add<ApplicationExceptionsFilter>();
            })
            .AddJsonOptions(o =>
            {
                o.JsonSerializerOptions.WriteIndented = Environment.IsDevelopment();
                o.JsonSerializerOptions.Converters.Add(new JsonStringEnumConverter());
                o.JsonSerializerOptions.AddCustomConverters();
            });

        services.AddApiVersioning(
            o =>
            {
                o.AssumeDefaultVersionWhenUnspecified = true;
                o.DefaultApiVersion = new ApiVersion(new DateTime(2017, 7, 17));
            });

        services.AddCommonApplicationServices(Configuration);
        services.AddReferralsApplication(Configuration);
        services.AddEReferralsApplication();
        services.AddPersonsApplication();
        services.AddOrganizationsApplication();
        services.AddLogEventsApplication();
        services.AddCallsApplication();
        services.AddTimeZonesApplication();
        services.AddEnumsApplication();
        services.AddHeartbeatApplication(Configuration);
        services.AddQAProcessorApplication(Configuration);

        services.AddReferralsHighLevelApplication(Configuration);
        services.AddLogEventsHighLevelApplication();
        services.AddPersonsHighLevelApplication();
        services.AddPhonesHighLevelApplication();

        services.AddAutoMapper(typeof(Startup), typeof(App.LowLevel.Calls.Mapping.CallMappingProfile));

        services.AddApplicationInsightsTelemetry(Configuration.GetSection("Azure:ApplicationInsights"));
        services.AddUserNameTelemetry();
    }

    public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
    {
        if (!env.IsDevelopment())
        {
            app.UseHsts();
        }

        app.UseHttpsRedirection();

        app.UseSwagger();

        app.UseSwaggerUI(c =>
        {
            c.SwaggerEndpoint("/swagger/v1/swagger.json", "V1 Docs");
            c.OAuthClientId("swagger");
            c.OAuthAppName("StatTrac API Web client for testing");
        });

        app.UseRouting();

        app.UseAuthentication();
        app.UseAuthorization();

        app.UseEndpoints(endpoints =>
        {
            endpoints.MapControllers().RequireAuthorization();
        });
    }
}
