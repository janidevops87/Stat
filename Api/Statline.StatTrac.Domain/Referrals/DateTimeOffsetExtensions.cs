using System.Collections.Concurrent;

namespace Statline.StatTrac.Domain.Referrals;

internal static class DateTimeOffsetExtensions
{
    private static readonly ConcurrentDictionary<string, TimeZoneInfo> TimeZoneInfoCache =
        new(StringComparer.InvariantCultureIgnoreCase);

    public static string ToTimeWithTimeZoneString(
        this DateTimeOffset sourceDateTime,
        string? timeZoneAbbreviation)
        => $"{sourceDateTime:HH:mm}" +
            (timeZoneAbbreviation is null ? string.Empty : $" {timeZoneAbbreviation}");

    public static DateTimeOffset ConvertToTimeZone(
      this DateTimeOffset dateTimeOffset,
      string ianaTimeZoneId)
    {
        Check.NotEmpty(ianaTimeZoneId);

        var timeZoneInfo = TimeZoneInfoCache.GetOrAdd(ianaTimeZoneId, LoadTimeZoneInfo);

        return dateTimeOffset.ConvertToTimeZone(timeZoneInfo);
    }

    public static DateTimeOffset ConvertToTimeZone(
       this DateTimeOffset dateTimeOffset,
       TimeZoneInfo timeZone)
    {
        Check.NotNull(timeZone);
        return TimeZoneInfo.ConvertTime(dateTimeOffset, timeZone);
    }

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