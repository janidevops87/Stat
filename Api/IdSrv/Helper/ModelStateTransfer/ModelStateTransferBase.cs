using Microsoft.AspNetCore.Mvc.Filters;

namespace Statline.IdentityServer.Helper.ModelStateTransfer
{
    public abstract class ModelStateTransferBase : ActionFilterAttribute
    {
        protected const string Key = nameof(ModelStateTransfer);
    }
}
