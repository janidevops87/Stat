using Statline.StatTrac.Infrastructure.Persistence.Ef.Common.Converters;

namespace Statline.StatTrac.Infrastructure.Persistence.Ef.Common;

internal abstract class EntityConfigurationBase
{
    protected DateTimeOffsetToStringConverter MountainTimeDateTimeOffsetToStringConverter
        => ValueConverters.DefaultTimeZoneDateTimeOffsetToStringConverter;
}
