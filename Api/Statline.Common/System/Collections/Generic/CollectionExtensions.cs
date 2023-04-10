using Statline.Common.Utilities;

namespace System.Collections.Generic
{
    public static class CollectionExtensions
    {
        public static void Add<T>(this ICollection<T> target, IEnumerable<T> collection)
        {
            Check.NotNull(target, nameof(target));
            Check.NotNull(collection, nameof(collection));
            
            // If we're adding ourselves, then there is nothing to do.
            if (ReferenceEquals(collection, target))
                return;

            // Try optimizations.
            if(target is List<T> targetList)
            {
                targetList.AddRange(collection);
                return;
            }

            foreach (T item in collection)
                target.Add(item);
        }
    }
}
