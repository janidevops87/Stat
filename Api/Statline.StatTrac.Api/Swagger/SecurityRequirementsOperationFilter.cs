using Microsoft.AspNetCore.Authorization.Infrastructure;
using Microsoft.AspNetCore.Mvc.Authorization;
using Microsoft.OpenApi.Models;
using Swashbuckle.AspNetCore.SwaggerGen;
using System.Linq;

namespace Statline.StatTrac.Api.Swagger;

/// <summary>
/// Translates different security policies attached to actions
/// into swagger annotations.
/// </summary>
internal class SecurityRequirementsOperationFilter : IOperationFilter
{
    public void Apply(OpenApiOperation operation, OperationFilterContext context)
    {
        // TODO: Authorize filters seems to be not populated in
        // the recent ASP.NET versions. Need to think how to work
        // this around.
        var authorizeFilters = context.ApiDescription
            .ActionDescriptor
            .FilterDescriptors
            .Select(fd => fd.Filter)
            .OfType<AuthorizeFilter>();

        var actionPolicies = authorizeFilters
            .Where(filter => filter.Policy != null)
            .Select(filter => filter.Policy);

        // Gather scopes which are required
        // for this action to be called.
        var requiredScopes = actionPolicies
            .SelectMany(x => x.Requirements)
            .OfType<ClaimsAuthorizationRequirement>()
            .Where(r => r.ClaimType == "scope")
            .SelectMany(x => x.AllowedValues ?? Enumerable.Empty<string>());

        if (authorizeFilters.Any())
        {
            operation.Responses.Add("401", new OpenApiResponse { Description = "Unauthorized" });
            operation.Responses.Add("403", new OpenApiResponse { Description = "Forbidden" });
        }

        // For OAuth2, Security Requirement Object
        // must contain scopes required to call the API.
        // https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#security-requirement-object
        if (requiredScopes.Any())
        {
            operation.Security = new List<OpenApiSecurityRequirement>
            {
                new ()
                {
                    {
                        new OpenApiSecurityScheme
                        {
                            Reference = new OpenApiReference
                            {
                                Type = ReferenceType.SecurityScheme,
                                Id = "OAuth2SecurityScheme"
                            },
                            Scheme = "oauth2",
                            Name = "Bearer",
                            In = ParameterLocation.Header,

                        },
                        requiredScopes.ToList()
                    }
                }
            };
        }
    }
}
