using Microsoft.OpenApi.Models;
using Swashbuckle.AspNetCore.SwaggerGen;
using System.Linq;

namespace Statline.StatTrac.Api.Swagger;

/// <summary>
/// Adds additional docs to operations which
/// have parameters of specified type. This allows to avoid
/// specifying the same lengthy comments for each action.
/// </summary>
/// <typeparam name="TParam">The type of parameter to search.</typeparam>
/// <remarks>
/// For example, if its needed to describe how date/time parameters should 
/// be formatted for all operation with such parameters, that information 
/// can be injected by this filter.
/// </remarks>
public class CommonParameterDocsOperationFilter<TParam> : IOperationFilter
{
    private readonly string commonParameterDoc;

    public CommonParameterDocsOperationFilter(
        string commonParameterDoc)
    {
        Check.NotEmpty(commonParameterDoc, nameof(commonParameterDoc));
        this.commonParameterDoc = commonParameterDoc;
    }

    public void Apply(OpenApiOperation operation, OperationFilterContext context)
    {
        bool hasParametersOfInterest =
            context.ApiDescription.ParameterDescriptions.Any(
                pd => pd.Type == typeof(TParam));

        if (!hasParametersOfInterest)
        {
            return;
        }

        operation.Description +=
            Environment.NewLine +
            Environment.NewLine +
            commonParameterDoc;
    }
}
