using Microsoft.OpenApi.Any;
using Microsoft.OpenApi.Models;
using Statline.StatTrac.Integration.Api.Swagger;
using Swashbuckle.AspNetCore.SwaggerGen;

namespace Statline.StatTrac.Integration.Api.Swagger;

internal static class SwaggerServiceCollectionExtensions
{
    public static void AddSwaggerGen(
        this IServiceCollection services,
        IConfiguration config)
    {
        services.AddSwaggerGen(c =>
        {
            c.SwaggerDoc("v1", new OpenApiInfo { Title = "StatTrac API", Version = "v1" });

            // This is a workaround for the issue when view model classes with the same
            // name but in different namespaces cause schema IDs collision. Here
            // we specify that namespace must be included in ID. This is not ideal,
            // as we expose internal implementation details to API docs. A better
            // workaround should be invented.
            c.CustomSchemaIds(type => type.ToString());
            c.MapCustomTypes();
        });
    }

    private static void MapCustomTypes(this SwaggerGenOptions c)
    {
        c.MapType<TimeSpan>(() => new OpenApiSchema
        {
            Type = "string",
            Example = new OpenApiString("00:00:00")
        });

        // Not supported yet: https://github.com/domaindrivendev/Swashbuckle.AspNetCore/issues/2319
        c.MapType<DateOnly>(() => new OpenApiSchema
        {
            Type = "string",
            // Doing parsing just to ensure the string has no mistakes.
            Example = new OpenApiString(DateOnly.Parse("2022-05-26").ToString("O"))
        });
    }
}
