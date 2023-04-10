using Microsoft.EntityFrameworkCore;
using Statline.Common.Utilities;
using Statline.StatTrac.Domain.QAProcessor;
using Statline.StatTrac.Infrastructure.Persistence.Ef.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

#nullable enable

namespace Statline.StatTrac.Infrastructure.Persistence.Ef.QAProcessor;

public class QAProcessorReferralRepository : IQAProcessorReferralRepository
{
    private readonly ReferralReportingDbContext referralDbContext;

    public QAProcessorReferralRepository(ReferralReportingDbContext referralDbContext)
    {
        this.referralDbContext = Check.NotNull(referralDbContext, nameof(referralDbContext));
    }

    public async Task<IEnumerable<HighRiskCallReferral>> GetHighRiskCallReferralsAsync(
        DateTimeOffset startDate,
        DateTimeOffset endDate)
    {
        var defaultTimeZone = referralDbContext.DefaultTimeZone;

        return await referralDbContext.Set<HighRiskCallReferral>()
            .FromSqlInterpolated(@$"EXEC [Api].[sps_QAProcessor.GetHighRiskCallReferrals] 
                    @StartDate={startDate.ConvertToTimeZone(defaultTimeZone).DateTime}, 
                    @EndDate={endDate.ConvertToTimeZone(defaultTimeZone).DateTime}")
            .AsNoTracking()
            .ToArrayAsync()
            .ConfigureAwait(false);
    }
}
