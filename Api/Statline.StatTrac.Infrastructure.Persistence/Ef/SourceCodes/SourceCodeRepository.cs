using Microsoft.EntityFrameworkCore;
using Statline.StatTrac.Domain.SourceCodes;
using System.Linq.Expressions;

namespace Statline.StatTrac.Infrastructure.Persistence.Ef.SourceCodes;

public class SourceCodeRepository : ISourceCodeRepository
{
    private readonly ReferralTransactionalDbContext referralDbContext;

    public SourceCodeRepository(
        ReferralTransactionalDbContext referralDbContext)
    {
        this.referralDbContext = Check.NotNull(referralDbContext);
    }

    public async Task<bool> AnySourceCodeExistsAsync(
        Expression<Func<SourceCode, bool>> predicate)
    {
        Check.NotNull(predicate);

        return await referralDbContext
            .Set<SourceCode>()
            .TagWithCallerName()
            .AnyAsync(predicate)
            .ConfigureAwait(false);
    }

    public IAsyncEnumerable<TResult> QuerySourceCodes<TResult>(
        Expression<Func<SourceCode, bool>> predicate,
        Expression<Func<SourceCode, TResult>> selector)
    {
        Check.NotNull(predicate);
        Check.NotNull(selector);

        var values = referralDbContext.Set<SourceCode>()
            .TagWithCallerName()
            .AsNoTracking()
            .Where(predicate)
            .Select(selector);

        return values.AsAsyncEnumerable();
    }
}
