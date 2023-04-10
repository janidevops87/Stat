using System.Globalization;

#nullable disable

namespace Statline.StatTrac.Domain.Referrals;

public sealed class ReferralId : IEquatable<ReferralId>
{
    public const int MinValue = 1;

    public int Value { get; }

    public ReferralId(int value)
    {
        Check.BiggerOrEqual(value, MinValue, nameof(value));
        Value = value;
    }

    public static ReferralId Parse(string str)
    {
        Check.NotEmpty(str, nameof(str));
        int value = int.Parse(str);
        return new ReferralId(value);
    }

    public bool Equals(ReferralId other)
    {
        if (ReferenceEquals(this, other))
            return true;

        if (other == null)
            return false;

        return EqualsCore(this, other);
    }

    public static bool Equals(ReferralId left, ReferralId right)
    {
        if (ReferenceEquals(left, right))
            return true;

        if (left == null || right == null)
        {
            return false;
        }

        return EqualsCore(left, right);
    }

    public override bool Equals(object obj) => Equals(obj as ReferralId);

    public override int GetHashCode() => Value.GetHashCode();

    public override string ToString() => Value.ToString(CultureInfo.InvariantCulture);

    public static  implicit operator ReferralId(int value)
        => new ReferralId(value);

    public static bool operator ==(ReferralId left, ReferralId right)
        => Equals(left, right);

    public static bool operator !=(ReferralId left, ReferralId right)
        => !(left == right);

    private static bool EqualsCore(ReferralId left, ReferralId right) =>
        left.Value == right.Value;

}
