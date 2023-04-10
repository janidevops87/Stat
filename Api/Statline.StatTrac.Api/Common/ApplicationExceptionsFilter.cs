using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.AspNetCore.Mvc;
using Statline.Common.Repository;
using Statline.StatTrac.Domain.Common;

namespace Statline.StatTrac.Api.Common;

public class ApplicationExceptionsFilter : IActionFilter, IOrderedFilter
{
    // This specifies an Order of the maximum integer value minus 10. This
    // Order allows other filters to run at the end of the pipeline.
    public int Order => int.MaxValue - 10;

    public void OnActionExecuting(ActionExecutingContext context) { }

    public void OnActionExecuted(ActionExecutedContext context)
    {
        if (context.Exception is EntityDoesntExistException)
        {
            context.Result = new NotFoundObjectResult(context.Exception.Message);
            context.ExceptionHandled = true;
        }
        else if (context.Exception is InvalidInputDataException)
        {
            context.Result = new BadRequestObjectResult(context.Exception.Message);
            context.ExceptionHandled = true;
        }
    }
}

