using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;

namespace Statline.StatTracUploader.Domain.Main.Referrals
{
    public interface IReferralRepository
    {
        Task AddReferralAsync(Referral referral, CancellationToken cancellationToken);
        Task<ICollection<int>> GetDuplicateReferralIdsAsync(
            DuplicateReferralsFilterCriteria filterCriteria,
            CancellationToken cancellationToken);
    }
}
