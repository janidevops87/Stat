using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.OpenApi.Any;
using Microsoft.OpenApi.Models;
using Statline.StatTrac.Api.ViewModels.Common;
using Swashbuckle.AspNetCore.SwaggerGen;

namespace Statline.StatTrac.Api.Swagger;

internal static class SwaggerServiceCollectionExtensions
{
    private static readonly string XmlCommentsPath = "Statline.StatTrac.Api.xml";

    public static void AddSwaggerGen(
        this IServiceCollection services,
        IConfiguration config)
    {
        var baseIdentityServerUri =
            new Uri(config["Authentication:IdentityServerUri"], UriKind.Absolute);

        var authorizationUrl = new Uri(
                baseIdentityServerUri,
                new Uri("connect/authorize", UriKind.Relative));

        var tokenUrl = new Uri(
                baseIdentityServerUri,
                new Uri("connect/token", UriKind.Relative));

        services.AddSwaggerGen(c =>
        {
            c.SwaggerDoc("v1", new OpenApiInfo { Title = "StatTrac API", Version = "v1" });

            // See https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#security-scheme-object.
            // Unfortunately, this swagger library supports only OpenAPI v2.0
            // (swagger) spec, which limits to only one OAuth2 flow 
            // (while token server supports multiple). 
            // Thus, we can't document more than one.
            // OpenAPI v3.0 supports multiple flows: 
            // https://swagger.io/docs/specification/authentication/oauth2/.
            c.AddSecurityDefinition("OAuth2SecurityScheme", new OpenApiSecurityScheme
            {
                Scheme = "oauth2",
                Name = "Bearer",
                In = ParameterLocation.Header,
                Type = SecuritySchemeType.OAuth2,
                // Use "implicit" flow since looks like
                // Swagger UI uses it.
                Flows = new OpenApiOAuthFlows
                {
                    AuthorizationCode = new OpenApiOAuthFlow
                    {
                        AuthorizationUrl = authorizationUrl,
                        TokenUrl = tokenUrl,
                        Scopes = new Dictionary<string, string>
                        {
                            { "statline.stattrac.api", "API access"  },
                        }
                    },

                    ClientCredentials = new OpenApiOAuthFlow
                    {
                        //  AuthorizationUrl = authorizationUrl,
                        TokenUrl = tokenUrl,
                        Scopes = new Dictionary<string, string>
                        {
                            { "statline.stattrac.api", "API access"  },
                        }
                    }
                }
            });

            c.AddDateTimeOffsetParamsCommonDoc();

            // Assign scope requirements to operations based on AuthorizeAttribute
            c.OperationFilter<SecurityRequirementsOperationFilter>();

            // This is a workaround for the issue when view model classes with the same
            // name but in different namespaces cause schema IDs collision. Here
            // we specify that namespace must be included in ID. This is not ideal,
            // as we expose internal implementation details to API docs. A better
            // workaround should be invented.
            c.CustomSchemaIds(type => type.ToString());
            c.MapCustomTypes();
        });

        services.ConfigureSwaggerGen(options =>
        {
            options.IncludeXmlComments(XmlCommentsPath);
        });
    }

    private static void MapCustomTypes(this SwaggerGenOptions c)
    {
        c.MapType<TimeSpan>(() => new OpenApiSchema
        {
            Type = "string",
            Example = new OpenApiString("00:00:00")
        });

        c.MapType<Domain.Common.PhoneNumber>(() => new OpenApiSchema
        {
            Type = "string",
            // Doing parsing just to ensure the string has no mistakes.
            Example = new OpenApiString(Domain.Common.PhoneNumber.Parse("123-456-7890").ToString())
        });

        c.MapType<Domain.Common.PhoneExtension>(() => new OpenApiSchema
        {
            Type = "string",
            // Doing parsing just to ensure the string has no mistakes.
            Example = new OpenApiString(new Domain.Common.PhoneExtension("1234567890").ToString())
        });

        c.MapType<PhoneNumberViewModel>(() => new OpenApiSchema
        {
            Type = "string",
            // Doing parsing just to ensure the string has no mistakes.
            Example = new OpenApiString(Domain.Common.PhoneNumber.Parse("123-456-7890").ToString())
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
