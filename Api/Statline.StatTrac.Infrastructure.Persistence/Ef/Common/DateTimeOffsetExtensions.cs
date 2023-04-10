using System;

namespace Statline.StatTrac.Infrastructure.Persistence.Ef.Common;

internal static class DateTimeOffsetExtensions
{
    public static DateTimeOffset ConvertToTimeZone(
        this DateTimeOffset dateTimeOffset,
        TimeZoneInfo timeZone)
    {
        return TimeZoneInfo.ConvertTime(dateTimeOffset, timeZone);
    }
}
