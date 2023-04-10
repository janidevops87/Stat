using Microsoft.EntityFrameworkCore;
using Statline.StatTrac.Domain.Calls;
using Statline.StatTrac.Domain.Common;
using Statline.StatTrac.Infrastructure.Persistence.Ef.Common;
using System.Linq.Expressions;

namespace Statline.StatTrac.Infrastructure.Persistence.Ef.Calls;

public class CallRepository : ICallRepository
{
    private readonly ReferralTransactionalDbContext referralDbContext;

    public CallRepository(
        ReferralTransactionalDbContext referralDbContext)
    {
        this.referralDbContext = Check.NotNull(referralDbContext);
    }

    public async Task AddCallAsync(Call call)
    {
        Check.NotNull(call);

        var defaultTimeZone = referralDbContext.DefaultTimeZone;

        var createdCallsList = await referralDbContext.Set<CallInsertResult>()
            .FromSqlInterpolated($@"EXEC InsertCall
                    @CallNumber = {call.CallNumber}, 
                    @CallTypeID = {call.CallTypeId}, 
                    @CallDateTime = {call.CallDateTime?.ConvertToTimeZone(defaultTimeZone).DateTime}, 
                    @StatEmployeeID = {call.StatEmployeeId}, 
                    @CallTotalTime = {call.CallTotalTime?.ToString("c")}, 
                    @CallTempExclusive = {call.CallTempExclusive}, 
                    @Inactive = {call.Inactive}, 
                    @CallSeconds = {call.CallSeconds}, 
                    @CallTemp = {call.CallTemp}, 
                    @SourceCodeID = {call.SourceCodeId}, 
                    @CallOpenByID = {call.CallOpenById}, 
                    @CallTempSavedByID = {call.CallTempSavedById}, 
                    @CallExtension = {call.CallExtension}, 
                    @CallOpenByWebPersonID = {call.CallOpenByWebPersonId}, 
                    @RecycleNCFlag = {call.RecycleNcFlag}, 
                    @CallActive = {call.CallActive}, 
                    @CallSaveLastByID = {call.CallSaveLastById}, 
                    @AuditLogTypeID = {call.AuditLogTypeId}")
            .TagWithCallerName()
            .AsNoTracking()
            .ToArrayAsync()
            .ConfigureAwait(false);

        var callInsertResult = createdCallsList.Single();

        // This resembles how EF assigns ids to entities after insertion to a table.
        // NOTE: This doesn't update all properties which
        // the sproc may have changed/generated.
        call.CallId = callInsertResult.CallId;
        call.CallNumber = callInsertResult.CallNumber;

        if (call.CallTemp is not (null or IntegerBoolean.ZeroFalse))
        {
            // TODO: Don't forget to also add this call
            // to call update when implemented.
            await UpdateCallIncopleteDate(call).ConfigureAwait(false);
        }
    }

    // Below are just my thoughts aloud.
    // The end goal of this call is not clear to me.
    // It adds/removes a record with current date/time
    // for each incomplete call. Not sure how these records are used then.
    // From design perspective, on one hand, adding/removing this information
    // is technically part of referral/call create/update. But on the other hand,
    // it doesn't seem to belong here, at least in this form of a separate
    // stored procedure. It seems to fit a DB trigger better.
    // Having that, I'm not sure what's the best place for this code.
    // Maybe, it should be explicit part of domain/application logic,
    // but for now I'm hiding it in repository implementation. Currently,
    // no application code needs to know about this piece of data.
    private async Task UpdateCallIncopleteDate(Call call)
    {
        await referralDbContext.Database.ExecuteSqlInterpolatedAsync(
            $@"EXEC UpdateCallIncompleteDate
                @CallID = {call.CallId},
                @StatEmployeeID = {call.StatEmployeeId},
                @IncompleteChecked = {(call.CallTemp is not (null or IntegerBoolean.ZeroFalse)).ToString()/*Do not try to simplify this*/}")
            .ConfigureAwait(false);
    }

    public async Task<TResult?> FindCallAsync<TResult>(
        int id,
        Expression<Func<Call, TResult>> selector) where TResult : notnull
    {
        Check.NotNull(selector, nameof(selector));

        return await referralDbContext.Calls.Include(call => call.CallType)
           .AsNoTracking()
           .Where(call => call.CallId == id)
           .Select(selector)
           .SingleOrDefaultAsync()
           .ConfigureAwait(false);
    }
}
