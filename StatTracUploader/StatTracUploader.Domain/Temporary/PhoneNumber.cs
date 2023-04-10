using Statline.Common.Utilities;
using System;
using System.Globalization;

namespace Statline.StatTracUploader.Domain.Temporary
{
    public record PhoneNumber
    {
        // TODO: Consider changing to real maximum values.
        public const int MaxAreaCode = 999;
        public const int MaxPrefix = 999;
        public const int MaxNumber = 9999;

        public string AreaCode { get; private set; }
        public string Prefix { get; private set; }
        public string Number { get; private set; }

        public PhoneNumber(
            string areaCode,
            string prefix,
            string number)
        {
            ValidateAreaCode(areaCode);
            ValidatePrefix(prefix);
            ValidateNumber(number);

            AreaCode = areaCode;
            Prefix = prefix;
            Number = number;
        }

        public PhoneNumber(
            ReadOnlySpan<char> areaCode,
            ReadOnlySpan<char> prefix,
            ReadOnlySpan<char> number)
        {
            ValidateAreaCode(areaCode);
            ValidatePrefix(prefix);
            ValidateNumber(number);

            AreaCode = areaCode.ToString();
            Prefix = prefix.ToString();
            Number = number.ToString();
        }

        public static PhoneNumber Parse(string formattedPhoneNumber)
        {
            Check.NotEmpty(formattedPhoneNumber, nameof(formattedPhoneNumber));

            var normalizedPhoneNumber =
                formattedPhoneNumber
                    .Replace("(", "")
                    .Replace(")", "")
                    .Replace("-", "")
                    .Replace(" ", "")
                    .AsSpan();

            if (normalizedPhoneNumber.Length != 10)
            {
                throw new FormatException(
                    $"Phone number must consist of 10 digits. " +
                    $"Actual value: '{formattedPhoneNumber}'.");
            }

            var areaCodePart = normalizedPhoneNumber[0..3];
            var prefixPart = normalizedPhoneNumber[3..6];
            var numberPart = normalizedPhoneNumber[6..10];

            return new PhoneNumber(areaCodePart, prefixPart, numberPart);
        }

        private static void ValidateNumber(ReadOnlySpan<char> numberPart)
        {
            if (!TryParsePhoneNumberPart(numberPart, out var number))
            {
                throw new FormatException(
                    $"Can't parse phone number from string '{numberPart.ToString()}'.");
            }

            Check.InRangeInclusive(number, 0, MaxNumber, nameof(number));
        }

        private static void ValidatePrefix(ReadOnlySpan<char> prefixPart)
        {
            if (!TryParsePhoneNumberPart(prefixPart, out var prefix))
            {
                throw new FormatException(
                    $"Can't parse phone prefix from string '{prefixPart.ToString()}'.");
            }

            Check.InRangeInclusive(prefix, 0, MaxPrefix, nameof(prefix));
        }

        private static void ValidateAreaCode(ReadOnlySpan<char> areaCodePart)
        {
            if (!TryParsePhoneNumberPart(areaCodePart, out var areaCode))
            {
                throw new FormatException(
                    $"Can't parse phone area code from string '{areaCodePart.ToString()}'.");
            }

            Check.InRangeInclusive(areaCode, 0, MaxAreaCode, nameof(areaCode));
        }

        private static bool TryParsePhoneNumberPart(
            ReadOnlySpan<char> part,
            out int partValue)
        {
            return int.TryParse(part,
                            NumberStyles.Integer,
                            CultureInfo.InvariantCulture,
                            out partValue);
        }

        public override string ToString()
        {
            return $"{AreaCode}-{Prefix}-{Number}";
        }
    }
}
