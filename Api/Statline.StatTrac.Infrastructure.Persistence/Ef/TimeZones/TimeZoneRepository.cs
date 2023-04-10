using Microsoft.EntityFrameworkCore;
using Statline.Common.Utilities;
using Statline.StatTrac.Domain.TimeZones;
using System;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;

namespace Statline.StatTrac.Infrastructure.Persistence.Ef.TimeZones;

public class TimeZoneRepository : ITimeZoneRepository
{
    private readonly ReferralTransactionalDbContext referralDbContext;

    public TimeZoneRepository(
        ReferralTransactionalDbContext referralDbContext)
    {
        this.referralDbContext = Check.NotNull(referralDbContext, nameof(referralDbContext));
    }

    public async Task<TResult?> FindTimeZoneAsync<TResult>(
        int id,
        Expression<Func<Domain.TimeZones.TimeZone, TResult>> selector) where TResult : notnull
    {
        Check.NotNull(selector, nameof(selector));

        return await referralDbContext.TimeZones
            .TagWithCallerName()
            .AsNoTracking()
            .Where(timeZone => timeZone.TimeZoneId == id)
            .Select(selector)
            .SingleOrDefaultAsync()
            .ConfigureAwait(false);
    }

    public async Task<Domain.TimeZones.TimeZone?> FindTimeZoneAsync(int id)
    {
        return await referralDbContext.TimeZones
            .TagWithCallerName()
            .AsNoTracking()
            .Where(timeZone => timeZone.TimeZoneId == id)
            .SingleOrDefaultAsync()
            .ConfigureAwait(false);
    }
}
