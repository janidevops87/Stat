using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;

namespace Statline.Ereferral.Web.Filters
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
                _logger.LogInformation($"{context.HttpContext.Session.Id ?? "NoSessionId"}--{context.ActionDescriptor.DisplayName} ({item.Key}) : {JsonConvert.SerializeObject(item.Value)}");
            }
        }

        public void OnActionExecuted(ActionExecutedContext context)
        {
            _logger.LogInformation($"{context.HttpContext.Session.Id ?? "NoSessionId"}--{context.ActionDescriptor.DisplayName}: ActionExecutedContext {JsonConvert.SerializeObject(context.Result)}");
        }
    }
}