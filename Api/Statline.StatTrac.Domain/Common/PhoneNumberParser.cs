using System.Globalization;

namespace Statline.StatTrac.Domain.Common;

public sealed class PhoneNumberParser
{
    public PhoneNumberValidator PhoneValidator { get; } = new();

    private const int ExpectedPhoneLength = 10;

    public void ParseParts(
        string formattedPhoneNumber,
        out ReadOnlySpan<char> areaCodePart,
        out ReadOnlySpan<char> prefixPart,
        out ReadOnlySpan<char> numberPart,
        CultureInfo? culture)
    {
        Check.NotEmpty(formattedPhoneNumber);

        ParsePartsCore(
            formattedPhoneNumber,
            out var tempAreaCodePart,
            out var tempPrefixPart,
            out var tempNumberPart);

        PhoneValidator.ValidateAreaCode(tempAreaCodePart, culture);
        PhoneValidator.ValidatePrefix(tempPrefixPart, culture);
        PhoneValidator.ValidateNumber(tempNumberPart, culture);

        areaCodePart = tempAreaCodePart;
        prefixPart = tempPrefixPart;
        numberPart = tempNumberPart;
    }

    public void ParsePartsWithoutValidation(
        string formattedPhoneNumber,
        out ReadOnlySpan<char> areaCodePart,
        out ReadOnlySpan<char> prefixPart,
        out ReadOnlySpan<char> numberPart)
    {
        Check.NotEmpty(formattedPhoneNumber);

        ParsePartsCore(
            formattedPhoneNumber,
            out areaCodePart,
            out prefixPart,
            out numberPart);
    }

    private static void ParsePartsCore(
        string formattedPhoneNumber,
        out ReadOnlySpan<char> areaCodePart,
        out ReadOnlySpan<char> prefixPart,
        out ReadOnlySpan<char> numberPart)
    {
        var normalizedPhoneNumber =
            formattedPhoneNumber
                .Replace("(", "")
                .Replace(")", "")
                .Replace("-", "")
                .Replace(" ", "")
                .AsSpan();

        if (normalizedPhoneNumber.Length != ExpectedPhoneLength)
        {
            throw new FormatException(
                $"Phone number must consist of {ExpectedPhoneLength} digits. " +
                $"Actual value: '{formattedPhoneNumber}'.");
        }

        areaCodePart = normalizedPhoneNumber[0..3];
        prefixPart = normalizedPhoneNumber[3..6];
        numberPart = normalizedPhoneNumber[6..10];
    }

    public PhoneNumber ParsePhoneNumber(string formattedPhoneNumber)
    {
        ParsePartsCore(
            formattedPhoneNumber,
            out var areaCodePart,
            out var prefixPart,
            out var numberPart);

        return new PhoneNumber(areaCodePart, prefixPart, numberPart);
    }
}
