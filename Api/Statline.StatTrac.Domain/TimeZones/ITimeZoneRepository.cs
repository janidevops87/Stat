using System.Linq.Expressions;

namespace Statline.StatTrac.Domain.TimeZones;

public interface ITimeZoneRepository
{
    Task<TResult?> FindTimeZoneAsync<TResult>(
        int id, Expression<Func<TimeZone, TResult>> selector)
        where TResult : notnull;
    Task<TimeZone?> FindTimeZoneAsync(int id);
}
