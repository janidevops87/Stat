using System.Linq.Expressions;

namespace Statline.StatTrac.Domain.SourceCodes;

public interface ISourceCodeRepository
{
    Task<bool> AnySourceCodeExistsAsync(
        Expression<Func<SourceCode, bool>> predicate);

    IAsyncEnumerable<TResult> QuerySourceCodes<TResult>(
        Expression<Func<SourceCode, bool>> predicate,
        Expression<Func<SourceCode, TResult>> selector);
}
