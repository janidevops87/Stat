using System.Diagnostics.CodeAnalysis;
using System.Linq;
using System.Reflection;

namespace Statline.StatTrac.App.ReferralProcessor;

internal abstract class ReflectionEqualityComparer<T> : EqualityComparer<T>
{
    private readonly IEnumerable<PropertyInfo> properties;

    protected ReflectionEqualityComparer(Func<PropertyInfo, bool>? propertyFilter = null)
    {
        var referralType = typeof(T);

        properties = referralType.GetRuntimeProperties();

        if (propertyFilter != null)
        {
            properties = properties.Where(propertyFilter);
        }

        properties = properties.ToArray();
    }

    public override bool Equals([AllowNull] T x, [AllowNull] T y)
    {
        if (ReferenceEquals(x, y))
        {
            return true;
        }

        if (x == null || y == null)
        {
            return false;
        }

        foreach (PropertyInfo pi in properties)
        {
            var leftValue = pi.GetValue(x);
            var rightValue = pi.GetValue(y);

            if (!Equals(leftValue, rightValue))
            {
                return false;
            }
        }

        return true;
    }

    public override int GetHashCode([DisallowNull] T obj)
    {
        if (obj == null)
        {
            return 0;
        }

        // TODO: This is obviously not the best implementation,
        // but should be OK for our needs. 
        // Here is an example of a better algorithm:
        // https://stackoverflow.com/questions/263400/what-is-the-best-algorithm-for-an-overridden-system-object-gethashcode/263416#263416

        int hashCode = 0;

        foreach (PropertyInfo pi in properties)
        {
            var value = pi.GetValue(obj);
            hashCode ^= value?.GetHashCode() ?? 0;
        }

        return hashCode;
    }
}
