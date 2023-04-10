using Statline.StatTrac.Domain.Referrals;
using System.Reflection;

namespace Statline.StatTrac.App.ReferralProcessor;

internal class ReferralEqualityComparer : ReflectionEqualityComparer<ReferralDetails>
{
    public static readonly ReferralEqualityComparer Instance =
        new ReferralEqualityComparer();

    private ReferralEqualityComparer()
        : base(BuildPropertyFilter())
    {
    }

    private static Func<PropertyInfo, bool> BuildPropertyFilter()
    {
        return pi =>
            !pi.Name.Equals(nameof(ReferralDetails.ReferralLastModified), StringComparison.Ordinal) &&
            !pi.Name.Equals(nameof(ReferralDetails.CallLastModified), StringComparison.Ordinal) &&
            !pi.Name.Equals(nameof(ReferralDetails.StatEmployee), StringComparison.Ordinal) &&
            !pi.Name.Equals(nameof(ReferralDetails.ReferralLogEvents), StringComparison.Ordinal) &&
            !pi.Name.Equals(nameof(ReferralDetails.SecondaryData), StringComparison.Ordinal);
    }

    public override bool Equals(ReferralDetails? x, ReferralDetails? y)
    {
        return base.Equals(x, y) &&
             ReferralSecondaryEqualityComparer.Instance.Equals(
                 x?.SecondaryData, y?.SecondaryData);
    }

    public override int GetHashCode(ReferralDetails obj)
    {
        if (obj == null)
        {
            return 0;
        }

        var secondaryDataHashCode =
            ReferralSecondaryEqualityComparer.Instance.GetHashCode(obj.SecondaryData);

        return
            base.GetHashCode(obj) ^
            secondaryDataHashCode;
    }
}
