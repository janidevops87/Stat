#nullable disable

namespace Statline.StatTrac.Domain.Referrals;

public sealed class ReferralMedicationOther : IEquatable<ReferralMedicationOther>
{
    public string Name { get; private set; }
    public string Dose { get; private set; }
    public DateTime? StartDate { get; private set; }
    public DateTime? EndDate { get; private set; }

    public bool Equals(ReferralMedicationOther other)
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
            string.Equals(Name, other.Name, StringComparison.Ordinal) &&
            string.Equals(Dose, other.Dose, StringComparison.Ordinal) &&
            StartDate == other.StartDate &&
            EndDate == other.EndDate;
    }

    public override bool Equals(object obj)
    {
        return Equals(obj as ReferralMedicationOther);
    }

    public override int GetHashCode()
    {
        return
            (Name?.GetHashCode() ?? 0) ^
            (Name?.GetHashCode() ?? 0) ^
            StartDate.GetHashCode() ^
            EndDate.GetHashCode();
    }
}
