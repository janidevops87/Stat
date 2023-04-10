namespace Statline.StatTrac.Domain.Common;

public record PhoneNumber
{
    private static readonly PhoneNumberParser PhoneNumberParser = new();

    public string AreaCode { get; private set; }
    public string Prefix { get; private set; }
    public string Number { get; private set; }

    public PhoneNumber(
        string areaCode,
        string prefix,
        string number)
    {
        var validator = PhoneNumberParser.PhoneValidator;

        validator.ValidateAreaCodeInvariant(areaCode);
        validator.ValidatePrefixInvariant(prefix);
        validator.ValidateNumberInvariant(number);

        AreaCode = areaCode;
        Prefix = prefix;
        Number = number;
    }

    public PhoneNumber(
        ReadOnlySpan<char> areaCode,
        ReadOnlySpan<char> prefix,
        ReadOnlySpan<char> number)
    {
        var validator = PhoneNumberParser.PhoneValidator;

        validator.ValidateAreaCodeInvariant(areaCode);
        validator.ValidatePrefixInvariant(prefix);
        validator.ValidateNumberInvariant(number);

        AreaCode = areaCode.ToString();
        Prefix = prefix.ToString();
        Number = number.ToString();
    }

    public override string ToString()
    {
        return $"{AreaCode}-{Prefix}-{Number}";
    }

    public static PhoneNumber Parse(string formattedPhoneNumber)
    {
        return PhoneNumberParser.ParsePhoneNumber(formattedPhoneNumber);
    }
}
