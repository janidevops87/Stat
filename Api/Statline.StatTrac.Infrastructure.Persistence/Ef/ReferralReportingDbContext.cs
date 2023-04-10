using Microsoft.EntityFrameworkCore;

namespace Statline.StatTrac.Infrastructure.Persistence.Ef;

public class ReferralReportingDbContext : ReferralDbContext<ReferralReportingDbContext>
{
    public ReferralReportingDbContext(DbContextOptions<ReferralReportingDbContext> options)
        : base(options)
    {
    }
}
