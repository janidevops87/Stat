using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using IdentityModel;
using Statline.Common.Utilities;

namespace Statline.IdentityServer.Common.Security
{
    internal static class ClaimsPrincipalExtensions
    {
        public static int GetTenantId(this ClaimsPrincipal principal)
        {
            Check.NotNull(principal, nameof(principal));

            var id = principal.FindFirstValue(StatlineClaimTypes.TenantIdClaim);

            if (string.IsNullOrEmpty(id))
            {
                throw new InvalidOperationException(
                    $"Tenant Id claim was not found on " +
                    $"the user '{principal.Identity.Name}'.");
            }

            return Convert.ToInt32(id);
        }

        public static IEnumerable<Claim> GetStatlineClaims(this ClaimsPrincipal principal)
        {
            Check.NotNull(principal, nameof(principal));

            var claims = principal.Claims.Where(c => c.Type.StartsWith("Statline."));

            return claims;
        }

        public static string GetUserId(this ClaimsPrincipal principal)
        {
            Check.NotNull(principal, nameof(principal));
            return principal.FindFirstValue(JwtClaimTypes.Subject);
        }

        public static string GetEmail(this ClaimsPrincipal principal)
        {
            Check.NotNull(principal, nameof(principal));
            return principal.FindFirstValue(JwtClaimTypes.Email);
        }

        public static string GetGivenName(this ClaimsPrincipal principal)
        {
            Check.NotNull(principal, nameof(principal));
            return principal.FindFirstValue(JwtClaimTypes.GivenName);
        }

        public static string GetFamilyName(this ClaimsPrincipal principal)
        {
            Check.NotNull(principal, nameof(principal));
            return principal.FindFirstValue(JwtClaimTypes.FamilyName);
        }

        public static IEnumerable<string> GetRoles(this ClaimsPrincipal principal)
        {
            Check.NotNull(principal, nameof(principal));
            return principal.Claims
                    .Where(c => c.Type == JwtClaimTypes.Role)
                    .Select(c => c.Value);
        }
    }
}
