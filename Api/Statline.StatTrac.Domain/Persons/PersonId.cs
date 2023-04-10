using System.Globalization;

namespace Statline.StatTrac.Domain.Persons;

public readonly record struct PersonId
{
    public const int MinValue = 1;

    public int Value { get; }
    public bool IsValid => Value >= MinValue;

    public PersonId(int value)
    {
        Check.BiggerOrEqual(value, MinValue, nameof(value));
        Value = value;
    }

    public static PersonId Parse(string str)
    {
        Check.NotEmpty(str, nameof(str));
        int value = int.Parse(str);
        return new PersonId(value);
    }

    public override string ToString() => Value.ToString(CultureInfo.InvariantCulture);

    public static implicit operator PersonId(int value) => new(value);
    public static implicit operator int(PersonId id) => id.Value;
}
