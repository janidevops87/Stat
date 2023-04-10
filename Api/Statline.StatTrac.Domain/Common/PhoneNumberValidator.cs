using System.Globalization;

namespace Statline.StatTrac.Domain.Common;

public class PhoneNumberValidator
{
    // TODO: Consider changing to real maximum values.
    public const int MaxAreaCode = 999;
    public const int MaxPrefix = 999;
    public const int MaxNumber = 9999;

    public void ValidateNumberInvariant(ReadOnlySpan<char> numberPart)
    {
        ValidateNumber(numberPart, CultureInfo.InvariantCulture);
    }

    public void ValidateNumber(ReadOnlySpan<char> numberPart, CultureInfo? culture)
    {
        if (!TryParsePhoneNumberPart(numberPart, culture, out var number))
        {
            throw new FormatException(
                $"Can't parse phone number part from string '{numberPart.ToString()}'.");
        }

        Check.InRangeInclusive(number, 0, MaxNumber, nameof(numberPart));
    }


    public void ValidatePrefixInvariant(ReadOnlySpan<char> prefixPart)
    {
        ValidatePrefix(prefixPart, CultureInfo.InvariantCulture);
    }

    public void ValidatePrefix(ReadOnlySpan<char> prefixPart, CultureInfo? culture)
    {
        if (!TryParsePhoneNumberPart(prefixPart, culture, out var prefix))
        {
            throw new FormatException(
                $"Can't parse phone prefix part from string '{prefixPart.ToString()}'.");
        }

        Check.InRangeInclusive(prefix, 0, MaxPrefix, nameof(prefixPart));
    }

    public void ValidateAreaCodeInvariant(ReadOnlySpan<char> areaCodePart)
    {
        ValidateAreaCode(areaCodePart, CultureInfo.InvariantCulture);
    }

    public void ValidateAreaCode(ReadOnlySpan<char> areaCodePart, CultureInfo? culture)
    {
        if (!TryParsePhoneNumberPart(areaCodePart, culture, out var areaCode))
        {
            throw new FormatException(
                $"Can't parse phone area code part from string '{areaCodePart.ToString()}'.");
        }

        Check.InRangeInclusive(areaCode, 0, MaxAreaCode, nameof(areaCodePart));
    }

    private static bool TryParsePhoneNumberPart(
        ReadOnlySpan<char> part,
        CultureInfo? culture,
        out int partValue)
    {
        return int.TryParse(part,
            NumberStyles.Integer,
            culture,
            out partValue);
    }
}
