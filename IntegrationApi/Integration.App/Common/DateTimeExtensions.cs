namespace Statline.StatTrac.Integration.App.Common;

internal static class DateTimeExtensions
{
    public static DateTimeOffset ToDateTimeOffset(this DateTime dateTime, TimeZoneInfo timeZone)
    {
        Check.NotNull(timeZone);

        // This prevents any problems in case the date/time is UTC or Local.
        // Our goal is to construct a DateTimeOffset with date/time
        // and time zone provided, not to convert to that time zone.
        dateTime = DateTime.SpecifyKind(dateTime, DateTimeKind.Unspecified);

        TimeSpan offset = timeZone.GetUtcOffset(dateTime);

        return new DateTimeOffset(dateTime, offset);
    }

    public static DateTime SpecifyKind(this DateTime dateTime, DateTimeKind kind)
    { 
        return DateTime.SpecifyKind(dateTime, kind);
    }
}
