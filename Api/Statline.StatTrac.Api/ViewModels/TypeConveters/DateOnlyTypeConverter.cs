using System.ComponentModel;
using System.Globalization;

namespace Statline.StatTrac.Api.ViewModels.TypeConveters;

// While DateOnly type was introduced in .Net 6.0, a TypeConverter for it
// will be added only in .Net 7.0.
// Details:
// https://github.com/dotnet/runtime/issues/68743
// https://github.com/dotnet/runtime/issues/59253
// This is a workaround for meanwhile.
#if NET7_0_OR_GREATER
#warning Switch to in-box DateOnly TypeConverter support.
#endif
internal class DateOnlyConverter : TypeConverter
{
    public override bool CanConvertFrom(ITypeDescriptorContext? context, Type sourceType)
    {
        if (sourceType == typeof(string))
            return true;
        return base.CanConvertFrom(context, sourceType);
    }

    public override bool CanConvertTo(ITypeDescriptorContext? context, Type? destinationType)
    {
        if (destinationType == typeof(string))
            return true;
        return base.CanConvertTo(context, destinationType);
    }

    public override object? ConvertFrom(ITypeDescriptorContext? context, CultureInfo? culture, object value)
    {
        if (value is string s)
            return DateOnly.Parse(s, culture);
        return base.ConvertFrom(context, culture, value);
    }

    public override object? ConvertTo(ITypeDescriptorContext? context, CultureInfo? culture, object? value, Type destinationType)
    {
        if (destinationType == typeof(string))
            return ((DateOnly?)value)?.ToString(culture);
        return base.ConvertTo(context, culture, value, destinationType);
    }

    public override bool IsValid(ITypeDescriptorContext? context, object? value)
    {
        if (value is DateOnly)
            return true;

        return base.IsValid(context, value);
    }

    public static void Register()
    {
        TypeDescriptor.AddAttributes(
            typeof(DateOnly), 
            new TypeConverterAttribute(typeof(DateOnlyConverter)));
    }
}
