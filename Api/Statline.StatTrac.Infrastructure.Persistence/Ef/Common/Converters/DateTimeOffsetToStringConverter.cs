using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using Statline.Common.Utilities;
using System;
using System.Globalization;
using System.Linq.Expressions;

namespace Statline.StatTrac.Infrastructure.Persistence.Ef.Common.Converters;

internal class DateTimeOffsetToStringConverter
    : ValueConverter<DateTimeOffset, string>
{
    public DateTimeOffsetToStringConverter(
        TimeZoneInfo timeZone,
        string toStringFormatString,
        params string[] parseFormatStrings)
        : base(
        CreateModelToProviderConversionExpression(
              timeZone,
              toStringFormatString),
        CreateProviderToModelConversionExpression(
              timeZone,
              parseFormatStrings))
    {
    }

    private static Expression<Func<DateTimeOffset, string>> CreateModelToProviderConversionExpression(
        TimeZoneInfo timeZone,
        string toStringFormatString)
    {
        Check.NotNull(timeZone, nameof(timeZone));
        Check.NotEmpty(toStringFormatString, nameof(toStringFormatString));

        return dto => dto.ConvertToTimeZone(timeZone).ToString(toStringFormatString, CultureInfo.InvariantCulture);
    }

    private static Expression<Func<string, DateTimeOffset>>
        CreateProviderToModelConversionExpression(
        TimeZoneInfo timeZone,
        string[] parseFormatStrings)
    {
        Check.NotNull(timeZone, nameof(timeZone));
        Check.HasNoEmpties(parseFormatStrings, nameof(parseFormatStrings));

        return str => DateTimeToDateTimeOffset(
            DateTime.ParseExact(
                str,
                parseFormatStrings,
                CultureInfo.InvariantCulture,
                DateTimeStyles.AllowWhiteSpaces),
            timeZone);
    }

    private static DateTimeOffset DateTimeToDateTimeOffset(
            DateTime dateTime,
            TimeZoneInfo timeZone)
    {
        return new DateTimeOffset(
            dateTime,
            timeZone.GetUtcOffset(dateTime));
    }
}
