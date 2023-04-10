using Statline.StatTrac.Domain.Common;
using System.ComponentModel;
using System.Globalization;

namespace Statline.StatTrac.Api.ViewModels.TypeConveters;

public class PhoneNumberTypeConverter : TypeConverter
{
    public override bool CanConvertFrom(ITypeDescriptorContext? context, Type sourceType)
    {
        if (sourceType == typeof(string))
        {
            return true;
        }

        return base.CanConvertFrom(context, sourceType);
    }

    public override bool CanConvertTo(ITypeDescriptorContext? context, Type? destinationType)
    {
        if (destinationType == typeof(string))
        {
            return true;
        }

        return base.CanConvertTo(context, destinationType);
    }

    public override object? ConvertFrom(ITypeDescriptorContext? context, CultureInfo? culture, object value)
    {
        if (value is null)
        {
            return null;
        }

        return PhoneNumber.Parse((string)value);
    }

    public override object? ConvertTo(ITypeDescriptorContext? context, CultureInfo? culture, object? value, Type destinationType)
    {
        if (value is null)
        {
            return null;
        }

        return ((PhoneNumber)value).ToString();
    }

    public static void Register()
    {
        TypeDescriptor.AddAttributes(
            typeof(PhoneNumber),
            new TypeConverterAttribute(typeof(PhoneNumberTypeConverter)));
    }
}
