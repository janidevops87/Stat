#nullable disable

namespace Statline.StatTrac.Domain.Referrals;

public sealed class ReferralMedication : IEquatable<ReferralMedication>
{
    public string Name { get; private set; }

    public override bool Equals(object obj)
    {
        return Equals(obj as ReferralMedication);
    }

    public bool Equals(ReferralMedication other)
    {
        if (ReferenceEquals(this, other))
        {
            return true;
        }

        if (other == null)
        {
            return false;
        }

        return
            string.Equals(Name, other.Name, StringComparison.Ordinal);
    }

    public override int GetHashCode()
    {
        return Name?.GetHashCode() ?? 0;
    }
}
