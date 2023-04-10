using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using System;

namespace Statline.StatTrac.Infrastructure.Persistence.Ef.Common.Converters;

/// <summary>
/// Converts <see cref="DateOnly?" /> to <see cref="DateTime?"/> and vice versa.
/// </summary>
// While DateOnly type was introduced in .Net 6.0, support
// of it in Entity Framework will be added only in .Net 7.0.
// Details:
// https://github.com/dotnet/efcore/issues/24507
// This is a workaround for meanwhile.
// CAUTION: As stated in comments,
// "It is a great workaround for anyone who want to just map to DateOnly/TimeOnly types,
// but I believe your solution won't easily understand querying on DateOnly/TimeOnly types,
// mapping from/to migrations, do scaffolding, etc. The official support for
// SQL Server should probably use date and time on the database when appropriate.
// [...]
// Another thing missing from the above is translations from properties/methods
// on DateOnly/TimeOnly; so this would only take care of reading and writing the values."
#if NET7_0_OR_GREATER
#warning Switch to in-box DateOnly EF support.
#endif
public class NullableDateOnlyConverter : ValueConverter<DateOnly?, DateTime?>
{
    /// <summary>
    /// Creates a new instance of this converter.
    /// </summary>
    public NullableDateOnlyConverter() : base(
        d => d == null
            ? null
            : new DateTime?(d.Value.ToDateTime(TimeOnly.MinValue)),
        d => d == null
            ? null
            : new DateOnly?(DateOnly.FromDateTime(d.Value)))
    {
    }
}