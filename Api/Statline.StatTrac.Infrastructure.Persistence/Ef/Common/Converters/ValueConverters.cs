using System;

namespace Statline.StatTrac.Infrastructure.Persistence.Ef.Common.Converters;

internal static class ValueConverters
{
    // Some date/time columns in the DB are stored
    // in Mountain Time zone, so we need to adjust to it.
    private static readonly Lazy<TimeZoneInfo> defaultTimeZone = new(
        () => LoadTimeZoneInfo("Mountain Standard Time"));

    public static TimeZoneInfo DefaultTimeZone => defaultTimeZone.Value;

    public static DateTimeOffsetToStringConverter DefaultTimeZoneDateTimeOffsetToStringConverter { get; }
         = new(defaultTimeZone.Value, toStringFormatString:
             "MM/dd/yy HH:mm",
             "MM/dd/yy HH:mm:ss",
             "MM/dd/yy HH:mm",
             "MM/dd/yy");

    private static TimeZoneInfo LoadTimeZoneInfo(string timeZoneId)
    {
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
