using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Threading.Tasks;

namespace Statline.StatTracUploader.Domain.Temporary
{
    public interface IReferralUploadRepository
    {
        void AddReferralUpload(ReferralUpload referral);
        IAsyncEnumerable<ReferralUpload> QueryReferralUploads(Expression<Func<ReferralUpload, bool>> predicate);
        IAsyncEnumerable<ReferralUpload> GetPendingReferralUploads();
        Task SaveChangesAsync();
    }
}