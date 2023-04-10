namespace Statline.StatTrac.BusinessVeracity.Common.Infrastructure.CallInformation.InContactPreloaded;

internal static class LoggerExtensions
{
    public static void LogLoadingInformationFromInContact(
        this ILogger logger)
    {
        logger.LogInformation("Loading information from InContact...");
    }
}
