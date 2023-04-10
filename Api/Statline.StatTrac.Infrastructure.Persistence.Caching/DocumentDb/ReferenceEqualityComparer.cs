using System.Runtime.CompilerServices;

namespace Statline.StatTrac.Infrastructure.Persistence.DocumentDb;

internal class ReferenceEqualityComparer<T> : EqualityComparer<T> where T : class
{
    public static ReferenceEqualityComparer<T> Instance = new ReferenceEqualityComparer<T>();

    public override bool Equals(T? x, T? y)
    {
        return object.ReferenceEquals(x, y);
    }

    public override int GetHashCode(T? obj)
    {
        if (obj == null)
        {
            return 0;
        }

        return RuntimeHelpers.GetHashCode(obj);
    }
}
