using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;

namespace Statline.IdentityServer.Helper.ModelStateTransfer
{
    /// <summary>
    /// Exports model state from TempData after GET action execution
    /// in the POST-REDIRECT-GET pattern. This is needed to preserve validation
    /// errors and field values.
    /// </summary>
    /// <remarks>
    /// Based on: https://andrewlock.net/post-redirect-get-using-tempdata-in-asp-net-core/.
    /// More on PRG pattern: https://en.wikipedia.org/wiki/Post/Redirect/Get.
    /// </remarks>
    public class ExportModelStateAttribute : ModelStateTransferBase
    {
        public override void OnActionExecuted(ActionExecutedContext context)
        {
            // Only export when ModelState is not valid
            if (!context.ModelState.IsValid)
            {
                // Export if we are redirecting
                if (context.Result is RedirectResult ||
                    context.Result is RedirectToRouteResult ||
                    context.Result is RedirectToActionResult)
                {
                    if (context.Controller is Controller controller &&
                        context.ModelState != null)
                    {
                        var modelState = ModelStateHelpers.SerialiseModelState(context.ModelState);
                        controller.TempData[Key] = modelState;
                    }
                }
            }

            base.OnActionExecuted(context);
        }
    }


}
