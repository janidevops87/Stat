using Microsoft.EntityFrameworkCore;

namespace Statline.StatTrac.Infrastructure.Persistence.Ef;

public class ReferralTransactionalDbContext : ReferralDbContext<ReferralTransactionalDbContext>
{
    public ReferralTransactionalDbContext(DbContextOptions<ReferralTransactionalDbContext> options)
        : base(options)
    {
    }
}
