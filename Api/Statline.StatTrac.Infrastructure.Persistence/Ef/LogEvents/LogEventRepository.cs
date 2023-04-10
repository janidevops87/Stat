using Microsoft.EntityFrameworkCore;
using Statline.Common.Utilities;
using Statline.StatTrac.Domain.LogEvents;
using Statline.StatTrac.Infrastructure.Persistence.Ef.Common;
using System;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;

namespace Statline.StatTrac.Infrastructure.Persistence.Ef.LogEvents;

public class LogEventRepository : ILogEventRepository
{
    private readonly ReferralTransactionalDbContext referralDbContext;

    public LogEventRepository(
        ReferralTransactionalDbContext referralDbContext)
    {
        this.referralDbContext = Check.NotNull(referralDbContext, nameof(referralDbContext));
    }

    public async Task AddLogEventAsync(LogEvent logEvent)
    {
        Check.NotNull(logEvent, nameof(logEvent));

        var defaultTimeZone = referralDbContext.DefaultTimeZone;

        // NOTE: LogEventNumber is actually ignored by the sproc,
        // and is calculated on the fly.
        var createdLogEventsList = await referralDbContext.Set<LogEventInsertResult>()
            .FromSqlInterpolated($@"EXEC InsertLogEvent
                    @CallID  = {logEvent.CallId},
                    @LogEventTypeID  = {logEvent.LogEventTypeId},
                    @LogEventDateTime = {logEvent.LogEventDateTime?.ConvertToTimeZone(defaultTimeZone).DateTime},
                    @LogEventNumber  = {logEvent.LogEventNumber},
                    @LogEventName = {logEvent.LogEventName},
                    @LogEventPhone = {logEvent.LogEventPhone},
                    @LogEventOrg = {logEvent.LogEventOrg},
                    @LogEventDesc = {logEvent.LogEventDesc},
                    @StatEmployeeID  = {logEvent.StatEmployeeId},
                    @LogEventCallbackPending = {logEvent.LogEventCallbackPending},
                    @ScheduleGroupID  = {logEvent.ScheduleGroupId},
                    @PersonID  = {logEvent.PersonId},
                    @OrganizationID  = {logEvent.OrganizationId},
                    @PhoneID  = {logEvent.PhoneId},
                    @LogEventContactConfirmed = {logEvent.LogEventContactConfirmed},
                    @LogEventCalloutDateTime = {logEvent.LogEventCalloutDateTime?.ConvertToTimeZone(defaultTimeZone).DateTime},
                    @LastStatEmployeeID  = {logEvent.LastStatEmployeeId},
                    @AuditLogTypeID  = {logEvent.AuditLogTypeId},
                    @LogEventDeleted = {logEvent.LogEventDeleted}")
            .TagWithCallerName()
            .AsNoTracking()
            .ToArrayAsync()
            .ConfigureAwait(false);

        var logEventInsertResult = createdLogEventsList.Single();

        // This resembles how EF assigns ids to entities after insertion to a table.
        logEvent.LogEventId = logEventInsertResult.LogEventId;
        logEvent.LogEventNumber = logEventInsertResult.LogEventNumber;
    }

    public async Task<TResult?> FindLogEventAsync<TResult>(
        int id,
        Expression<Func<LogEvent, TResult>> selector) where TResult : notnull
    {
        Check.NotNull(selector, nameof(selector));

        return await referralDbContext.LogEvents.Include(le => le.LogEventType)
           .TagWithCallerName()
           .AsNoTracking()
           .Where(logEvent => logEvent.LogEventId == id)
           .Select(selector)
           .SingleOrDefaultAsync()
           .ConfigureAwait(false);
    }
}
