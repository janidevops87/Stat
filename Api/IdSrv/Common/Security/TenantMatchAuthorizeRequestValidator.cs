using System.Threading.Tasks;
using IdentityModel;
using IdentityServer4.Validation;
using Statline.Common.Utilities;

namespace Statline.IdentityServer.Common.Security
{
    /// <summary>
    /// This validator checks if a user on whose behalf a client requests 
    /// a token has the same tenant as the client. If tenants are different
    /// authorization request is rejected with an error.
    /// </summary>
    internal class TenantMatchAuthorizeRequestValidator : ICustomAuthorizeRequestValidator
    {
        public static readonly string TenantIdPropertyKey = "TenantId";

        public Task ValidateAsync(CustomAuthorizeRequestValidationContext context)
        {
            Check.NotNull(context, nameof(context));

            if (!context.Result.ValidatedRequest.Subject.Identity.IsAuthenticated)
            {
                return Task.CompletedTask;
            }

            var clientTenantId =
                context.Result.ValidatedRequest.Client.GetTenantId();

            var userTenantId =
                context.Result.ValidatedRequest.Subject.GetTenantId();

            if (clientTenantId != userTenantId)
            {
                var result = context.Result;

                result.IsError = true;

                // Error should be a standard error code, see specs:
                // https://tools.ietf.org/html/rfc6749#section-4.1.2.1
                // http://openid.net/specs/openid-connect-core-1_0.html#AuthError
                //
                // Depending on error code IdentityServer may redirect 
                // to an error page or return the error to the client.
                // The AccessDenied error code results in the latter.
                // See how decision is made here: 
                // https://github.com/IdentityServer/IdentityServer4/blob/c1487475eac111971272936fcaf4a2a32a55d2a8/src/IdentityServer4/Endpoints/Results/AuthorizeResult.cs#L72
                //
                result.Error = OidcConstants.AuthorizeErrors.AccessDenied;
                result.ErrorDescription =
                    "User's tenant doesn't match the tenant of the application. " +
                    "The likely cause of this error is that the user tries to log in " +
                    "to an application (client) which is not registered within " +
                    "the same tenant as the user.";
            }

            return Task.CompletedTask;
        }
    }
}
