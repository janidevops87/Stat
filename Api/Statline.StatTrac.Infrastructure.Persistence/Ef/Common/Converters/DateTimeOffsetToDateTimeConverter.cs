using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using Statline.Common.Utilities;
using System;
using System.Linq.Expressions;

namespace Statline.StatTrac.Infrastructure.Persistence.Ef.Common.Converters;

internal class DateTimeOffsetToDateTimeConverter
    : ValueConverter<DateTimeOffset, DateTime>
{

    public DateTimeOffsetToDateTimeConverter(TimeZoneInfo timeZone)
        : base(
          CreateModelToProviderConversionExpression(Check.NotNull(timeZone, nameof(timeZone))),
          CreateProviderToModelConversionExpression(timeZone))
    {
    }

    private static Expression<Func<DateTimeOffset, DateTime>>
        CreateModelToProviderConversionExpression(TimeZoneInfo timeZone)
    {
        return dto => dto.ConvertToTimeZone(timeZone).DateTime;
    }

    private static Expression<Func<DateTime, DateTimeOffset>>
        CreateProviderToModelConversionExpression(TimeZoneInfo timeZone)
    {
        return dt => new DateTimeOffset(dt, timeZone.GetUtcOffset(dt));
    }
}
