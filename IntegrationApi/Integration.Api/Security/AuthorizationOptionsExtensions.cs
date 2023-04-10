using Microsoft.AspNetCore.Authorization;

namespace Statline.StatTrac.Integration.Api.Security;

internal static class AuthorizationOptionsExtensions
{
    public static void AddCopernicusPolicy(this AuthorizationOptions options)
    {
        options.AddPolicy(
            AuthorizationPolicies.Copernicus,
            policy => policy
                .RequireScope("stattrac.integration.api.copernicus"));
    }
}
