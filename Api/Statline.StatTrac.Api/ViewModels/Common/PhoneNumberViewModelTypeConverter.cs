using Statline.StatTrac.Domain.Common;
using System.ComponentModel;
using System.Globalization;

namespace Statline.StatTrac.Api.ViewModels.Common;

public class PhoneNumberViewModelTypeConverter : TypeConverter
{
    private static readonly PhoneNumberParser PhoneNumberParser = new();

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

        return ParsePhoneNumber((string)value, culture);
    }

    public override object? ConvertTo(ITypeDescriptorContext? context, CultureInfo? culture, object? value, Type destinationType)
    {
        if (value is null)
        {
            return null;
        }

        var viewModel = (PhoneNumberViewModel)value;

        return new PhoneNumber(
            viewModel.AreaCode,
            viewModel.Prefix,
            viewModel.Number).ToString();
    }

    public static PhoneNumberViewModel ParsePhoneNumber(
        string formattedPhoneNumber,
        CultureInfo? culture)
    {
        PhoneNumberParser.ParseParts(
            formattedPhoneNumber,
            out var areaCodePart,
            out var prefixPart,
            out var numberPart,
            culture);

        return new PhoneNumberViewModel(
            areaCodePart.ToString(),
            prefixPart.ToString(),
            numberPart.ToString());
    }
}
