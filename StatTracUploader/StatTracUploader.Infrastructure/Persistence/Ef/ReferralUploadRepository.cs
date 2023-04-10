using Microsoft.EntityFrameworkCore;
using Statline.Common.Utilities;
using Statline.StatTracUploader.Domain.Temporary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;

namespace Statline.StatTracUploader.Infrastructure.Persistence.Ef
{
    public class ReferralUploadRepository<TDbContext> : IReferralUploadRepository
        where TDbContext : ReferralDbContext<TDbContext>
    {
        private readonly TDbContext referralDbContext;

        public ReferralUploadRepository(TDbContext referralDbContext)
        {
            Check.NotNull(referralDbContext, nameof(referralDbContext));
            this.referralDbContext = referralDbContext;
        }

        public void AddReferralUpload(ReferralUpload referralUpload)
        {
            Check.NotNull(referralUpload, nameof(referralUpload));

            referralDbContext.Add(referralUpload);
        }

        public IAsyncEnumerable<ReferralUpload> QueryReferralUploads(
            Expression<Func<ReferralUpload, bool>> predicate)
        {
            Check.NotNull(predicate, nameof(predicate));

            return referralDbContext.ReferralUploads
                .AsNoTracking()
                .Where(predicate)
                .AsAsyncEnumerable();
        }

        public IAsyncEnumerable<ReferralUpload> GetPendingReferralUploads()
        {
            // Here we imply that referrals are regularly processed,
            // so there should be not many with pending status. Therefore,
            // return all at once with no fear!
            return referralDbContext.ReferralUploads
                .AsQueryable()
                .Where(ru => ru.ProcessingStatus.Status == ProcessingStatus.Pending)
                .AsAsyncEnumerable();
        }

        public async Task SaveChangesAsync()
        {
            await referralDbContext.SaveChangesAsync().ConfigureAwait(false);
        }
    }
}
