using System.Linq.Expressions;

namespace Statline.StatTrac.Domain.Calls;

public interface ICallRepository
{
    Task AddCallAsync(Call call);
    Task<TResult?> FindCallAsync<TResult>(int id, Expression<Func<Call, TResult>> selector)
        where TResult : notnull;
}
