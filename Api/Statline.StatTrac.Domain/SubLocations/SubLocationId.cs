using System.Globalization;

namespace Statline.StatTrac.Domain.SubLocations;

public readonly record struct SubLocationId
{
    public const int MinValue = 1;

    public int Value { get; }

    public SubLocationId(int value)
    {
        Check.BiggerOrEqual(value, MinValue, nameof(value));
        Value = value;
    }

    public SubLocationId()
    {
        throw new InvalidOperationException(
            "And identifier must be explicitly provided with value during construction");
    }

    public static SubLocationId Parse(string str)
    {
        Check.NotEmpty(str, nameof(str));
        int value = int.Parse(str);
        return new SubLocationId(value);
    }

    public override string ToString() => Value.ToString(CultureInfo.InvariantCulture);

    public static implicit operator SubLocationId(int value) => new(value);
    public static implicit operator int(SubLocationId id) => id.Value;
}
