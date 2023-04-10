using Microsoft.Extensions.DependencyInjection;
using Swashbuckle.AspNetCore.SwaggerGen;

namespace Statline.StatTrac.Api.Swagger;

internal static class SwaggerGenOptionsExtensions
{
    public static void AddDateTimeOffsetParamsCommonDoc(this SwaggerGenOptions options)
    {
        options.OperationFilter<CommonParameterDocsOperationFilter<DateTimeOffset>>(
@"The date and time must be specified according to ISO 8601, using one of the following two formats:

•	Local date/time: 2017-10-25T01:00:00-0700. In this format you specify the date and time as well as your time zone offset.

•	UTC date/time: 2017-10-25T01:00:00Z In this format you append Z to the end of date and time to indicate you are specifying UTC time.

Date and time not matching the above format may produce inaccurate results. ");
    }
}
