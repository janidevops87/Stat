using Microsoft.Extensions.Logging;
using System.Security.Claims;

namespace Statline.Statrac.IdentityServerIntegration.DomainEventHandlers
{
    internal static class LoggerExtensions
    {
        public static void LogFailedToParseWebReportGroupId(
            this ILogger logger,
            Claim claim)
        {
            logger.LogWarning(
                "Claim value '{ClaimValue}' doesn't contain " +
                "correct WebReportGroupId.",
                claim.Value);
        }

        public static void LogExtractedWebReportGroupId(
            this ILogger logger,
            int webReportGroupId)
        {
            logger.LogInformation(
                "Extracted WebReportGroupId={WRGID}.", webReportGroupId);
        }

        public static void LogExpectedClaim(
            this ILogger logger,
            Claim claim)
        {
            logger.LogInformation(
                "Received expected claim type '{ClaimType}', " +
                "with value '{ClaimValue}'.",
                claim.Type,
                claim.Value);
        }

        public static void LogClaimIsOutOfInterest(
            this ILogger logger,
            Claim claim)
        {
            logger.LogInformation(
                "Received claim type '{ClaimType}' is " +
                "is out of interest, skipping.", claim.Type);
        }
    }
}
