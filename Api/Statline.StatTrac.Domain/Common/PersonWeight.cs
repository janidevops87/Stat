using System.Globalization;
using static System.Math;

namespace Statline.StatTrac.Domain.Common;

public record PersonWeight
{
    private readonly float value = default;
    private readonly WeightUnit unit = default;

    public float Value
    {
        get => value;
        init { this.value = Check.Bigger(value, 0f, nameof(Value)); }
    }

    public WeightUnit Unit
    {
        get => unit;
        init
        {
            unit = Enum.IsDefined(value) ? value : throw new ArgumentException("Unknown weight unit", nameof(Unit));
        }
    }

    public PersonWeight(float value, WeightUnit unit)
    {
        Value = value;
        Unit = unit;
    }

    public PersonWeight ToKilograms()
    {
        double ratio = Unit switch
        {
            WeightUnit.Kilograms => 1,
            WeightUnit.Grams => 0.001,
            WeightUnit.Pounds => 0.45359237,
            WeightUnit.Ounces => 0.02834949,
            _ => throw new InvalidOperationException("Unknown weight unit.")
        };

        double weightInKg = Round(Value * ratio, digits: 1, MidpointRounding.AwayFromZero);

        return new PersonWeight((float)weightInKg, WeightUnit.Kilograms);
    }

    public override string ToString()
    {
        return
            $"{value.ToString("0.#", CultureInfo.InvariantCulture)} " +
            $"{GetWeightUnitName(Unit)}";
    }

    private static string GetWeightUnitName(WeightUnit? weightUnit)
    {
        return weightUnit switch
        {
            WeightUnit.Kilograms => "kg",
            WeightUnit.Grams => "g",
            WeightUnit.Pounds => "lbs",
            WeightUnit.Ounces => "oz",
            _ => throw new InvalidOperationException("Unknown weight unit.") // should not happen
        };
    }
}
