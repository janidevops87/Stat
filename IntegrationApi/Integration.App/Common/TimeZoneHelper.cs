namespace Statline.StatTrac.Integration.App.Common;

internal static class TimeZoneHelper
{
    public static TimeZoneInfo LoadTimeZoneInfo(string timeZoneId)
    {
        Check.NotEmpty(timeZoneId);

        TimeZoneInfo timeZone;

        try
        {
            timeZone = TimeZoneInfo.FindSystemTimeZoneById(timeZoneId);
        }
        catch (Exception ex) when (
            ex is TimeZoneNotFoundException ||
            ex is InvalidTimeZoneException)
        {
            throw new ArgumentException(
                $"Failed to load TimeZoneInfo for time zone ID " +
                $"'{timeZoneId}': {ex.Message}",
                nameof(timeZoneId),
                ex);
        }

        return timeZone;
    }
}
