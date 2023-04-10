using Statline.Common.Utilities;
using System;

namespace Statline.StatTracUploader.Infrastructure.FileParsers.Excel.Extensions
{
    internal static class DateTimeExtensions
    {
        public static DateTimeOffset ToDateTimeOffset(this DateTime dateTime, TimeZoneInfo timeZone)
        {
            Check.NotNull(timeZone, nameof(timeZone));

            TimeSpan offset = timeZone.GetUtcOffset(dateTime);

            return new DateTimeOffset(dateTime, offset);
        }
    }
}
