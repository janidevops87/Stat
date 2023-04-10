using System.Linq.Expressions;

namespace Statline.StatTrac.Domain.LogEvents;

public interface ILogEventRepository
{
    Task AddLogEventAsync(LogEvent logEvent);
    Task<TResult?> FindLogEventAsync<TResult>(int id, Expression<Func<LogEvent, TResult>> selector)
        where TResult : notnull;
}
