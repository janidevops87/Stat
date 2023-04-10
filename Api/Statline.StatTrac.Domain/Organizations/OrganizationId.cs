using System.Globalization;

namespace Statline.StatTrac.Domain.Organizations;

public readonly record struct OrganizationId
{
    public const int MinValue = 1;

    public int Value { get; }

    public OrganizationId(int value)
    {
        Check.BiggerOrEqual(value, MinValue, nameof(value));
        Value = value;
    }

    public OrganizationId()
    {
        throw new InvalidOperationException(
            "And identifier must be explicitly provided with value during construction");
    }

    public static OrganizationId Parse(string str)
    {
        Check.NotEmpty(str, nameof(str));
        int value = int.Parse(str);
        return new OrganizationId(value);
    }

    public override string ToString() => Value.ToString(CultureInfo.InvariantCulture);

    public static implicit operator OrganizationId(int value) => new(value);
    public static implicit operator int(OrganizationId id) => id.Value;
}
