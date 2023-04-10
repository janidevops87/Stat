using Microsoft.EntityFrameworkCore;
using Statline.Common.Utilities;
using Statline.StatTrac.Domain.QAProcessor;
using System;
using System.Linq;
using System.Threading.Tasks;

#nullable enable

namespace Statline.StatTrac.Infrastructure.Persistence.Ef.QAProcessor;

public class QAProcessorCallRepository : IQAProcessorCallRepository
{
    private readonly ReferralReportingDbContext referralDbContext;

    public QAProcessorCallRepository(ReferralReportingDbContext referralDbContext)
    {
        this.referralDbContext = Check.NotNull(referralDbContext, nameof(referralDbContext));
    }

    public async Task<CallTimings?> GetCallTimingsAsync(int callId, TimeSpan defaultCallDuration)
    {
        return await referralDbContext.Set<CallTimings>()
            .FromSqlInterpolated(
                @$"EXEC [Api].[sps_QAProcessor.GetTimeFrameVoiceCalls] 
                        @CallId={callId}, 
                        @DefaultTimeFrameInSeconds={defaultCallDuration.TotalSeconds}")
            .AsNoTracking()
            .AsAsyncEnumerable()
            .SingleOrDefaultAsync()
            .ConfigureAwait(false);
    }
}
