using Statline.StatTrac.Domain.Referrals;
using System.Linq;
using System.Reflection;

namespace Statline.StatTrac.App.ReferralProcessor;

internal class ReferralSecondaryEqualityComparer : ReflectionEqualityComparer<ReferralSecondary>
{
    public static readonly ReferralSecondaryEqualityComparer Instance =
        new ReferralSecondaryEqualityComparer();

    public ReferralSecondaryEqualityComparer()
        : base(BuildPropertyFilter())
    {
    }

    private static Func<PropertyInfo, bool> BuildPropertyFilter()
    {
        return pi =>
            !pi.Name.Equals(nameof(ReferralSecondary.Medications), StringComparison.Ordinal) &&
            !pi.Name.Equals(nameof(ReferralSecondary.Antibiotics), StringComparison.Ordinal) &&
            !pi.Name.Equals(nameof(ReferralSecondary.Steroids), StringComparison.Ordinal);
    }

    public override bool Equals(ReferralSecondary? x, ReferralSecondary? y)
    {
        return
            base.Equals(x, y) &&
            // TODO: Think how to make reflection 
            // comparer handle collections.
            SequenceEqual(x?.Medications, y?.Medications) &&
            SequenceEqual(x?.Antibiotics, y?.Antibiotics) &&
            SequenceEqual(x?.Steroids, y?.Steroids);
    }

    private static bool SequenceEqual<T>(IEnumerable<T>? x, IEnumerable<T>? y)
    {
        if (ReferenceEquals(x, y))
            return true;

        if (x == null || y == null)
            return false;

        return Enumerable.SequenceEqual(x, y);
    }
}
