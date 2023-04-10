using Microsoft.EntityFrameworkCore;
using Statline.Common.Utilities;
using Statline.StatTrac.Domain.RegistryStatuses;
using System.Linq;
using System.Threading.Tasks;

namespace Statline.StatTrac.Infrastructure.Persistence.Ef.RegistryStatuses;

public class RegistryStatusRepository : IRegistryStatusRepository
{
    private readonly ReferralTransactionalDbContext referralDbContext;

    public RegistryStatusRepository(
        ReferralTransactionalDbContext referralDbContext)
    {
        this.referralDbContext = Check.NotNull(referralDbContext, nameof(referralDbContext));
    }

    public async Task AddRegistryStatusAsync(RegistryStatus registryStatus)
    {
        Check.NotNull(registryStatus, nameof(registryStatus));

        var createdRegistryStatusList = await referralDbContext.Set<RegistryStatusInsertResult>()
            .FromSqlInterpolated($@"EXEC InsertRegistryStatus
                    @RegistryStatus = {registryStatus.Status},
                    @CallID  = {registryStatus.CallId},
                    @LastStatEmployeeID = {registryStatus.LastStatEmployeeId},
                    @AuditLogTypeID  = {registryStatus.AuditLogTypeId}")
            .TagWithCallerName()
            .AsNoTracking()
            .ToArrayAsync()
            .ConfigureAwait(false);

        var registryStatusInsertResult = createdRegistryStatusList.Single();

        // This resembles how EF assigns ids to entities after insertion to a table.
        registryStatus.Id = registryStatusInsertResult.Id;
    }
}
