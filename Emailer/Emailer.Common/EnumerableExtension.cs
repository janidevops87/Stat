using Statline.Common.Utilities;
using System.Linq;

namespace System.Collections.Generic
{
    public static class EnumerableExtension
    {
        public static IEnumerable<T> WhereNotNull<T>(
            this IEnumerable<T?> collection) where T : class
        {
            Check.NotNull(collection, nameof(collection));
            return collection
                .Where(item => item is not null)
                .Select(item => item!);
        }
    }
}
