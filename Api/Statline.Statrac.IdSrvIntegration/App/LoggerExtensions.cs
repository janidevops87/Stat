using Microsoft.Extensions.Logging;

namespace Statline.Statrac.IdentityServerIntegration.App
{
    internal static class LoggerExtensions
    {
        public static void LogConfigurationRegistered(
            this ILogger logger,
            int webReportGroupId, 
            int? configId)
        {
            logger.LogInformation(
            "Successfully registered StatTrac API " +
            "configuration for WebReportGroupID={WRGID}, " +
            "ConfigurationId={configId}",
            webReportGroupId,
            configId);
        }

        public static void LogFailedToRegisterConfiguration(
            this ILogger logger,
            int webReportGroupId)
        {
            logger.LogError(
                "Failed to register StatTrac API " +
                "configuration for WebReportGroupID={WRGID} (possibly wrong WRGID value)", webReportGroupId);
        }

        public static void LogRegisteringConfiguration(
            this ILogger logger,
            int webReportGroupId)
        {
            logger.LogInformation(
                "Registering StatTrac API configuration for WebReportGroupID={WRGID}",
                webReportGroupId);
        }
    }
}
