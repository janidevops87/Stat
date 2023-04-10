using System.Linq;
using Microsoft.AspNetCore.Identity;

namespace Statline.IdentityServer.IdentityAndAccess.App.Common
{
    internal static class IdentityResultExtensions
    {
        public static void ThrowIfFailed(this IdentityResult identityResult)
        {
            if (!identityResult.Succeeded)
            {
                // TODO: Refactor to support multiple errors if needed.
                var errorMessage =
                    identityResult.Errors.FirstOrDefault()?.Description ?? "Unknown error";

                throw new ApplicationServiceException(errorMessage);
            }
        }
    }
}
