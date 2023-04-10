using System.Globalization;

namespace Statline.StatTrac.Domain.Phones;

public readonly record struct PhoneId
{
    public const int MinValue = 1;

    public int Value { get; }
    public bool IsValid => Value >= MinValue;

    public PhoneId(int value)
    {
        Check.BiggerOrEqual(value, MinValue, nameof(value));
        Value = value;
    }

    public static PhoneId Parse(string str)
    {
        Check.NotEmpty(str, nameof(str));
        int value = int.Parse(str);
        return new PhoneId(value);
    }

    public override string ToString() => Value.ToString(CultureInfo.InvariantCulture);

    public static implicit operator PhoneId(int value) => new(value);
    public static implicit operator int(PhoneId id) => id.Value;
}
