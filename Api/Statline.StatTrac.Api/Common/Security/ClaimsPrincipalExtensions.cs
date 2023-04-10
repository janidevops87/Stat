using Statline.StatTrac.Domain.Referrals;
using System.Linq;
using System.Security.Claims;

namespace Statline.StatTrac.Api.Common.Security;

internal static class ClaimsPrincipalExtensions
{
    public static ValueTask<int?> GetAssociatedStatEmployeeIdAsync(this ClaimsPrincipal principal)
    {
        // This is User ID. It won't be present for
        // clients which are services which don't
        // impersonate any user (Client Credentials Grant).
        // NOTE: An API should only be used with access tokens,
        // not with identity tokens. An access token
        // may or may not include user ID claim.
        // In case it doesn't, the "userinfo" token server
        // endpoint can be used to get the user information.
        // https://identityserver4.readthedocs.io/en/latest/endpoints/userinfo.html.
        // NOTE: Depending on authentication settings the claim type for User ID
        // can also be "sub". It's better to tune this via the settings than to
        // try both claims.
        var subClaim =
            principal.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier) ??
            principal.FindFirst("sub");

        if (subClaim is null)
        {
            // If the client is a service with no user impersonated,
            // we get the default employee ID from a special claim
            // added to the client registration.
            return ValueTask.FromResult(principal.GetDefaultStatEmployeeId());
        }

        // TODO: Implement stat employee lookup here or somewhere else
        // (this method is just a draft design of how this can be done).
        throw new NotImplementedException("User clients support is not implemented yet");
    }

    public static int? GetDefaultStatEmployeeId(this ClaimsPrincipal principal)
    {
        string? idClaim = principal.FindFirst(ClaimTypes.DefaultStatEmployeeIdClaim)?.Value;

        if (idClaim is null) return null;

        if (int.TryParse(idClaim, out int id))
        {
            return id;
        }

        throw new InvalidOperationException(
            $"Invalid value in of '{ClaimTypes.DefaultStatEmployeeIdClaim}' claim: {idClaim}");
    }

    public static string? GetWebReportGroupId(this ClaimsPrincipal principal)
    {
        return principal.FindFirst(ClaimTypes.WebReportGroupIdClaim)?.Value;
    }

    public static void SetWebReportGroupId(
        this ClaimsPrincipal principal,
        WebReportGroupId webReportGroupId)
    {
        Check.NotNull(webReportGroupId, nameof(webReportGroupId));

        if (principal.Identity is ClaimsIdentity claimsIdentity)
        {
            claimsIdentity.RemoveExistingWrgidClaims();

            claimsIdentity.AddClaim(new Claim(
                    ClaimTypes.WebReportGroupIdClaim,
                    webReportGroupId.ToString()));
        }
        else
        {
            throw new InvalidOperationException(
                $"Principal identity is not {nameof(ClaimsIdentity)}");
        }
    }

    private static void RemoveExistingWrgidClaims(this ClaimsIdentity claimIdentity)
    {
        var existingWrgidClaims = claimIdentity
                        .FindAll(ClaimTypes.WebReportGroupIdClaim)
                        .ToArray();

        foreach (var claim in existingWrgidClaims)
        {
            claimIdentity.RemoveClaim(claim);
        }
    }
}
