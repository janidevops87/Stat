using Statline.StatTrac.BusinessVeracity.Common.Domain;

namespace Statline.StatTrac.BusinessVeracity.Common.Application;

public interface IReferralSource<TReferral> where TReferral : ReferralDetails
{
    IAsyncEnumerable<TReferral> GetReferralsAsync(
        DateTimeOffset from,
        DateTimeOffset to);
}
