using System.Globalization;

namespace Statline.StatTrac.Domain.Common;

public record PhoneExtension
{
    public const int MaxNumberOfDigits = 10;

    public string Value { get; private set; }

    public PhoneExtension(string value)
    {
        Check.NotNull(value, nameof(value));
        ValidateExtension(value);
        Value = value;
    }

    private void ValidateExtension(string extension)
    {
        try
        {
            ParseExtension(extension);
        }
        catch (Exception ex) when (ex is FormatException or OverflowException)
        {
            throw new FormatException(
                $"Can't parse phone extension from string '{extension}': {ex.Message}", ex);
        }

        if (extension.Length > MaxNumberOfDigits)
        {
            throw new FormatException(
                $"Phone extension can contain max. {MaxNumberOfDigits} digits. " +
                $"Actual number of digits : '{extension.Length}'.");
        }
    }

    private static long ParseExtension(string value)
    {
        return long.Parse(value,
            NumberStyles.None,
            provider: CultureInfo.InvariantCulture);
    }

    public override string ToString()
    {
        return Value;
    }

    public long ToInt64()
    {
        // We are sure this will succeed.
        return ParseExtension(Value);
    }
}
