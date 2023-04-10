using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;

namespace Stattrac.Reporting.Filters
{
    public class LogActionFilter : IActionFilter
    {
        private ILogger _logger;

        public LogActionFilter(ILogger<LogActionFilter> logger)
        {
            _logger = logger;
        }

        public void OnActionExecuting(ActionExecutingContext context)
        {
            foreach (var item in context.ActionArguments)
            {
                _logger.LogWarning($"{context.HttpContext.Request.Headers}, {context.ActionDescriptor.DisplayName} ({item.Key}) : {JsonConvert.SerializeObject(item.Value)}");
            }
        }

        public void OnActionExecuted(ActionExecutedContext context)
        {
            _logger.LogWarning($"{context.ActionDescriptor.DisplayName}: ActionExecutedContext {JsonConvert.SerializeObject(context.Result)}");
        }
    }
}