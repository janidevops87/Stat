using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;

namespace Statline.IdentityServer.Helper.ModelStateTransfer
{
    /// <summary>
    /// Imports model state to TempData after POST action execution
    /// in the POST-REDIRECT-GET pattern. This is needed to preserve validation
    /// errors and field values.
    /// </summary>
    /// <remarks>
    /// Based on: https://andrewlock.net/post-redirect-get-using-tempdata-in-asp-net-core/.
    /// More on PRG pattern: https://en.wikipedia.org/wiki/Post/Redirect/Get.
    /// </remarks>
    public class ImportModelStateAttribute : ModelStateTransferBase
    {
        public override void OnActionExecuted(ActionExecutedContext context)
        {
            var controller = context.Controller as Controller;

            if (controller?.TempData[Key] is string serialisedModelState)
            {
                // Only Import if we are viewing
                if (context.Result is ViewResult)
                {
                    var modelState = ModelStateHelpers.DeserialiseModelState(serialisedModelState);
                    context.ModelState.Merge(modelState);
                }
                else
                {
                    // Otherwise remove it.
                    controller.TempData.Remove(Key);
                }
            }

            base.OnActionExecuted(context);
        }
    }
}
