namespace Statline.StatTrac.Infrastructure.Persistence.Ef.Common.Converters;

// This converter exists because in DbContext.ConfigureConventions method
// if you're specifying default converter for a set of properties you can't
// specify a converter instance, only type. That means you can't provide
// the time zone parameter to the constructor.
// See https://github.com/dotnet/efcore/issues/28085.
internal class DefaultTimeZoneDateTimeOffsetToDateTimeConverter :
    DateTimeOffsetToDateTimeConverter
{
    public DefaultTimeZoneDateTimeOffsetToDateTimeConverter() :
        base(ValueConverters.DefaultTimeZone)
    {
    }
}
