using Microsoft.EntityFrameworkCore;
using Statline.StatTrac.Domain.Phones;
using Statline.StatTrac.Infrastructure.Persistence.Ef.Common;
using System.Linq.Expressions;

namespace Statline.StatTrac.Infrastructure.Persistence.Ef.Phones;

public class PhoneRepository :
    RepositoryBase<ReferralTransactionalDbContext, OrganizationPhone>,
    IPhoneRepository
{
    public PhoneRepository(
        ReferralTransactionalDbContext referralDbContext)
        : base(referralDbContext)
    {
    }

    public IAsyncEnumerable<TResult> QueryOrganizationPhones<TResult>(
       Expression<Func<OrganizationPhone, bool>> predicate,
       Expression<Func<OrganizationPhone, TResult>> selector) =>
        QueryEntities(predicate, selector);

    public async Task<bool> AnyOrganizationPhoneExistsAsync(
       Expression<Func<OrganizationPhone, bool>> predicate) =>
        await AnyEntityExistsAsync(predicate).ConfigureAwait(false);

    public async Task AddPhoneAsync(Phone phone)
    {
        if (phone is OrganizationPhone organizationPhone)
        {
            await AddOrganizationPhone(organizationPhone);
        }
        else
        {
            throw new InvalidOperationException(
                $"Only instances of {nameof(OrganizationPhone)} are currently supported.");
        }
    }

    private async Task AddOrganizationPhone(
        OrganizationPhone phone)
    {
        var createdPhonesList = await DbContext.Set<PhoneInsertResult>()
            .FromSqlInterpolated($@"EXEC OrganizationPhoneInsert
                @OrganizationPhoneID = NULL, -- Not used by the sproc
		        @OrganizationID = {phone.OrganizationId},
		        @PhoneID = NULL,
		        @Phone = {phone.PhoneAreaCode + phone.PhonePrefix + phone.PhoneNumber},
		        @PhoneTypeID = {phone.PhoneTypeId},
		        @PhoneType = NULL,
		        @LastModified = NULL, -- Assigned by the sproc.
		        @LastStatEmployeeId = {phone.OrganizationPhoneLastStatEmployeeId},
		        @AuditLogTypeId = {phone.OrganizationPhoneAuditLogTypeId},
		        @SubLocationID = {phone.SubLocationId},
		        @SubLocation = NULL, -- Not used by the sproc.
		        @SubLocationLevelID = NULL, -- Legacy column, not used anymore.
		        @SubLocationLevel = {phone.SubLocationLevel},
		        @Inactive = {phone.OrganizationPhoneInactive}")
            .TagWithCallerName()
            .ToArrayAsync()
            .ConfigureAwait(false);

        var phoneInsertResult = createdPhonesList.Single();

        phone.PhoneId = phoneInsertResult.PhoneId;
        phone.OrganizationPhoneId = phoneInsertResult.OrganizationPhoneId;
    }
}
