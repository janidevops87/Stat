using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.HttpLogging;
using Microsoft.IdentityModel.Tokens;
using Statline.Common.Services;
using Statline.Extensions.Logging;
using Statline.StatTrac.Integration.Api.Security;
using Statline.StatTrac.Integration.Api.Swagger;
using Statline.StatTrac.Integration.Api.ViewModels.Common.Converters;
using Statline.StatTrac.Integration.App.Copernicus;
using Statline.StatTrac.Integration.Infrastructure;
using System.Text.Json.Serialization;

var builder = WebApplication.CreateBuilder(args);

builder.Host.ConfigureAppConfiguration((hostingContext, builder) =>
{
    var env = hostingContext.HostingEnvironment;
    AddAzureKeyVault(env, builder);
});

builder.Logging.AddEmailLog(builder.Configuration, "Logging:Email");

// Add services to the container.

builder.Services.AddControllers(options => options.SuppressOutputFormatterBuffering = true)
    .AddJsonOptions(o =>
    {
        o.JsonSerializerOptions.WriteIndented = builder.Environment.IsDevelopment();
        o.JsonSerializerOptions.Converters.Add(new JsonStringEnumConverter());
        o.JsonSerializerOptions.AddCustomConverters();
    });

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(builder.Configuration);

builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(JwtBearerDefaults.AuthenticationScheme, options =>
    {
        options.Authority = builder.Configuration["Authentication:IdentityServerUri"];

        options.TokenValidationParameters = new TokenValidationParameters
        {
            // Disabling audience (API Resource Name) validation because
            // we do scope validation, and the scopes are defined
            // in API Resources, either dedicated or shared by several resources.
            // More about this here: https://identityserver4.readthedocs.io/en/latest/topics/resources.html#api-resources
            ValidateAudience = false
        };
    });

builder.Services.AddAuthorization(options =>
{
    options.AddCopernicusPolicy();
});

builder.Services.AddAutoMapper(
    typeof(Program));

builder.Services.Configure<HttpLoggingOptions>(
    builder.Configuration.GetRequiredSection("Logging:HttpLoggingOptions"));

AddApplicationServices();

var app = builder.Build();

if (!app.Environment.IsDevelopment())
{
    app.UseHsts();
}

app.UseHttpsRedirection();

app.UseSwagger();
app.UseSwaggerUI();

app.UseHttpLogging();

app.UseAuthentication();
app.UseAuthorization();

app.MapControllers().RequireAuthorization();

app.Run();

void AddApplicationServices()
{
    builder.Services.AddSingleton<IDateTimeService, DateTimeService>();

    builder.Services.AddStatTracApiClient(
        clientConfig: builder.Configuration.GetSection("StatTracApiClient"),
        authConfig: builder.Configuration.GetSection("StatTracApiClient:Authentication"));

    builder.Services.AddCopernicusApp();
}

static void AddAzureKeyVault(
    IHostEnvironment env,
    IConfigurationBuilder builder)
{
    // Use base config to load Azure KeyVault settings.
    var baseConfig = builder.Build();

    // Loading secrets from azure key vault adds
    // noticeable delay on each app start. So we prefer
    // user secrets provider during development.
    if (env.IsDevelopment())
    {
        // We don't want a developer who downloaded fresh sources
        // to investigate why some parts of the app are not getting
        // needed credentials. Therefore, if local user secrets were
        // not filled and explicitly marked as such, fall back to
        // key vault secrets. This can also be used to test with key
        // vault in dev environment if we want.
        if (baseConfig["UserSecretsInitializedMarker"] is not null)
        {
            return;
        }

        // TODO: Log warning to bring attention to development
        // life cycle slowdown.
    }

    // Azure KeyVault should go first to make possible
    // using both KeyVault from test environment with secrets for 
    // external services (like test DB) and hard-coded non-secure 
    // secrets for storage emulators 
    // (which override secrets for test environment).
    builder.AddAzureKeyVaultIfConfigured(
        baseConfig.GetSection("Azure:KeyVault"),
            "IntegrationApi",
            "Common");
}
