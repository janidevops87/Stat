using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Query;
using System.Runtime.CompilerServices;

namespace Statline.StatTrac.Infrastructure.Persistence.Ef;

internal static class EntityFrameworkQueryableExtensions
{

    public static IQueryable<T> TagWithCallerName<T>(
        this IQueryable<T> source,
        [NotParameterized][CallerMemberName] string? callerName = null)
    {
        return source.TagWith("Caller method: " + callerName ?? "<Unknown caller>");
    }

}
