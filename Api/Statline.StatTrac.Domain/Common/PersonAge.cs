using System.Globalization;

namespace Statline.StatTrac.Domain.Common;

public readonly record struct PersonAge
{
    private readonly int value = default;
    private readonly AgeUnit unit = default;

    public int Value
    {
        get => value;
        init { this.value = Check.BiggerOrEqual(value, 0, nameof(Value)); }
    }

    public AgeUnit Unit
    {
        get => unit;
        init
        {
            unit = Enum.IsDefined(value) ? value : throw new ArgumentException("Unknown age unit", nameof(Unit));
        }
    }

    public PersonAge(int value, AgeUnit unit)
    {
        Value = value;
        Unit = unit;
    }

    public void Deconstruct(out int value, out AgeUnit unit)
    {
        value = this.value;
        unit = this.unit;
    }

    public override string ToString()
    {
        return
            $"{value.ToString(CultureInfo.InvariantCulture)} " +
            $"{Unit.ToString().ToLower()}";
    }
}

