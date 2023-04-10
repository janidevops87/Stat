using System.Globalization;

namespace Statline.StatTrac.Domain.Referrals;

public sealed class WebReportGroupId : IEquatable<WebReportGroupId>
{
    public static readonly int MinValue = 1;

    public int Value { get; }

    public WebReportGroupId(int value)
    {
        Check.BiggerOrEqual(value, MinValue, nameof(value));
        Value = value;
    }

    public static WebReportGroupId Parse(string str)
    {
        Check.NotEmpty(str, nameof(str));
        int value = int.Parse(str);
        return new WebReportGroupId(value);
    }

    public bool Equals(WebReportGroupId? other)
    {
        if (ReferenceEquals(this, other))
            return true;

        if (other is null)
            return false;

        return EqualsCore(this, other);
    }

    public static bool Equals(WebReportGroupId? left, WebReportGroupId? right)
    {
        if (ReferenceEquals(left, right))
            return true;

        if (left is null || right is null)
        {
            return false;
        }

        return EqualsCore(left, right);
    }

    public override bool Equals(object? obj) => Equals(obj as WebReportGroupId);

    public override int GetHashCode() => Value.GetHashCode();

    public override string ToString() => Value.ToString(CultureInfo.InvariantCulture);

    public static bool operator ==(WebReportGroupId? left, WebReportGroupId? right)
        => Equals(left, right);

    public static bool operator !=(WebReportGroupId? left, WebReportGroupId? right)
        => !(left == right);

    private static bool EqualsCore(WebReportGroupId left, WebReportGroupId right) =>
        left.Value == right.Value;

}
